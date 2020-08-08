using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NuGet.Packaging.Core;
using NuGet.Versioning;

namespace nuget2bazel
{
    public class WorkspaceParser
    {
        private readonly string _toparse;
        private int _pos = 0;

        public WorkspaceParser(string toparse)
        {
            _toparse = toparse;
        }

        public IEnumerable<WorkspaceEntry> Parse()
        {
            return ParseEntries();
        }

        public class UnexpectedToken : Exception
        {
            public UnexpectedToken(string literal)
            {
                Literal = literal;
            }

            public string Literal { get; }
        }

        private IEnumerable<WorkspaceEntry> ParseEntries()
        {
            var result = new List<WorkspaceEntry>();

            for (; ; )
            {
                var entry = ParseEntry();
                if (entry == null)
                    break;
                result.Add(entry);
            }

            return result;
        }

        private WorkspaceEntry ParseEntry()
        {
            while (!IsEof() && IsWhitespace()) ++_pos;

            if (IsEof())
                return null;

            var result = new WorkspaceEntry();

            string package = null;
            string version = null;

            RequireToken(TokenCode.NUGET_PACKAGE);
            RequireToken(TokenCode.LPAR);

            var finished = false;
            while (!finished)
            {
                var (token, val) = PeekToken();
                switch (token)
                {
                    case TokenCode.NAME:
                        RequireToken(TokenCode.NAME);
                        RequireToken(TokenCode.EQUAL);
                        try
                        {
                            RequireToken(TokenCode.STRING);
                        }
                        catch (UnexpectedToken ex)
                        {
                            result.Variable = ex.Literal;
                        }
                        break;
                    case TokenCode.SOURCE:
                        RequireToken(TokenCode.SOURCE);
                        RequireToken(TokenCode.EQUAL);
                        RequireToken(TokenCode.SOURCE);
                        result.NugetSourceCustom = true;
                        break;
                    case TokenCode.CORE_FILES:
                        result.Core_Files = RequireDictionaryList(TokenCode.CORE_FILES);
                        break;
                    case TokenCode.CORE_LIB:
                        result.CoreLib = RequireDictionary(TokenCode.CORE_LIB);
                        break;
                    case TokenCode.CORE_REF:
                        result.CoreRef = RequireDictionary(TokenCode.CORE_REF);
                        break;
                    case TokenCode.MONO_DEPS:
                        result.Mono_Deps = RequireArray(TokenCode.MONO_DEPS);
                        break;
                    case TokenCode.MONO_FILES:
                        result.Mono_Files = RequireArray(TokenCode.MONO_FILES);
                        break;
                    case TokenCode.MONO_LIB:
                        result.MonoLib = RequireAssignment(TokenCode.MONO_LIB);
                        break;
                    case TokenCode.MONO_REF:
                        result.MonoRef = RequireAssignment(TokenCode.MONO_REF);
                        break;
                    case TokenCode.NET_DEPS:
                        result.Net_Deps = RequireDictionaryList(TokenCode.NET_DEPS);
                        break;
                    case TokenCode.NET_FILES:
                        result.Net_Files = RequireDictionaryList(TokenCode.NET_FILES);
                        break;
                    case TokenCode.NET_LIB:
                        result.NetLib = RequireDictionary(TokenCode.NET_LIB);
                        break;
                    case TokenCode.NET_REF:
                        result.NetRef = RequireDictionary(TokenCode.NET_REF);
                        break;
                    case TokenCode.PACKAGE:
                        package = RequireAssignment(TokenCode.PACKAGE);
                        break;
                    case TokenCode.VERSION:
                        version = RequireAssignment(TokenCode.VERSION);
                        break;
                    case TokenCode.SHA256:
                        result.Sha256 = RequireAssignment(TokenCode.SHA256);
                        break;
                    case TokenCode.CORE_TOOL:
                        result.CoreTool = RequireDictionary(TokenCode.CORE_TOOL);
                        break;
                    case TokenCode.NET_TOOL:
                        result.NetTool = RequireDictionary(TokenCode.NET_TOOL);
                        break;
                    case TokenCode.MONO_TOOL:
                        result.MonoTool = RequireAssignment(TokenCode.MONO_TOOL);
                        break;
                    case TokenCode.CORE_DEPS:
                        result.Core_Deps = RequireDictionaryList(TokenCode.CORE_DEPS);
                        break;
                    case TokenCode.RPAR:
                        finished = true;
                        GetToken();
                        break;
                }

            }

            result.PackageIdentity = new PackageIdentity(package, new NuGetVersion(version));

            return result;
        }

        private string RequireToken(TokenCode required)
        {
            var (token, value) = GetToken();
            if (token != required)
                throw new InvalidOperationException($"Unexpected token {token}, {value}. Expected {required}");

            return value;
        }

        private string RequireAssignment(TokenCode required)
        {
            var token = PeekToken();
            if (token.Item1 != required)
                return null;

            RequireToken(required);
            RequireToken(TokenCode.EQUAL);
            return RequireToken(TokenCode.STRING);
        }

        private IDictionary<string, string> RequireDictionary(TokenCode required)
        {
            var tok = PeekToken();
            if (tok.Item1 != required)
                return null;

            RequireToken(required);
            RequireToken(TokenCode.EQUAL);
            RequireToken(TokenCode.LCURLY);

            var result = new Dictionary<string, string>();
            for (; ; )
            {
                var (token, value) = GetToken();
                if (token == TokenCode.STRING)
                {
                    RequireToken(TokenCode.COLON);
                    var (token2, value2) = GetToken();
                    if (token2 != TokenCode.STRING)
                        throw new InvalidOperationException($"Unexpected token {token2}, {value2}. Expected TokenCode.STRING");

                    result.Add(value, value2);
                    continue;
                }

                if (token == TokenCode.RCURLY)
                    break;
            }

            return result;
        }

        private IDictionary<string, IEnumerable<string>> RequireDictionaryList(TokenCode required)
        {
            var tok = PeekToken();
            if (tok.Item1 != required)
                return null;

            RequireToken(required);
            RequireToken(TokenCode.EQUAL);
            RequireToken(TokenCode.LCURLY);

            var result = new Dictionary<string, IEnumerable<string>>();
            for (; ; )
            {
                var (token, value) = GetToken();
                if (token == TokenCode.STRING)
                {
                    RequireToken(TokenCode.COLON);
                    var (token2, value2) = GetToken();
                    if (token2 != TokenCode.LBRACKET)
                        throw new InvalidOperationException($"Unexpected token {token2}, {value2}. Expected TokenCode.LBRACKET");

                    var val = GetArrayValue();

                    result.Add(value, val);
                    continue;
                }

                if (token == TokenCode.RCURLY)
                    break;
            }

            return result;
        }

        private IEnumerable<string> GetArrayValue()
        {
            var result = new List<string>();
            for (; ; )
            {
                var (token, value) = GetToken();
                if (token == TokenCode.STRING)
                {
                    result.Add(value);
                    continue;
                }

                if (token == TokenCode.RBRACKET)
                    break;
            }

            return result;
        }

        private IEnumerable<string> RequireArray(TokenCode required)
        {
            var tok = PeekToken();
            if (tok.Item1 != required)
                return null;

            RequireToken(required);
            RequireToken(TokenCode.EQUAL);
            RequireToken(TokenCode.LBRACKET);

            return GetArrayValue();
        }

        public enum TokenCode
        {
            NUGET_PACKAGE,
            NAME,
            PACKAGE,
            VERSION,
            SHA256,
            CORE_LIB,
            NET_LIB,
            MONO_LIB,
            CORE_REF,
            NET_REF,
            MONO_REF,
            CORE_TOOL,
            NET_TOOL,
            MONO_TOOL,
            CORE_DEPS,
            NET_DEPS,
            MONO_DEPS,
            LBRACKET,
            RBRACKET,
            LPAR,
            RPAR,
            CORE_FILES,
            NET_FILES,
            MONO_FILES,
            STRING,
            EOF,
            ERROR,
            EQUAL,
            COLON,
            LCURLY,
            RCURLY,
            LITERAL,
            SOURCE,
        }

        public struct Token
        {
            public TokenCode Code;
            public string Value;
        }

        private (TokenCode, string) GetToken()
        {
            while (!IsEof() && IsWhitespace()) ++_pos;

            if (IsEof()) return (TokenCode.EOF, null);

            switch (_toparse[_pos])
            {
                case '(':
                    ++_pos;
                    return (TokenCode.LPAR, null);
                case ')':
                    ++_pos;
                    return (TokenCode.RPAR, null);
                case '[':
                    ++_pos;
                    return (TokenCode.LBRACKET, null);
                case ']':
                    ++_pos;
                    return (TokenCode.RBRACKET, null);
                case '=':
                    ++_pos;
                    return (TokenCode.EQUAL, null);
                case ':':
                    ++_pos;
                    return (TokenCode.COLON, null);
                case '{':
                    ++_pos;
                    return (TokenCode.LCURLY, null);
                case '}':
                    ++_pos;
                    return (TokenCode.RCURLY, null);
            }

            if (_toparse[_pos] == '\"')
                return GetString();

            int q;
            for (q = _pos; !IsSeparator(_toparse[q]) && q < _toparse.Length; ++q) ;
            var str = _toparse.Substring(_pos, q - _pos);
            _pos = q;

            if (str == "source") return (TokenCode.SOURCE, null);
            if (str == "nuget_package") return (TokenCode.NUGET_PACKAGE, null);
            if (str == "name") return (TokenCode.NAME, null);
            if (str == "package") return (TokenCode.PACKAGE, null);
            if (str == "version") return (TokenCode.VERSION, null);
            if (str == "sha256") return (TokenCode.SHA256, null);
            if (str == "core_lib") return (TokenCode.CORE_LIB, null);
            if (str == "net_lib") return (TokenCode.NET_LIB, null);
            if (str == "mono_lib") return (TokenCode.MONO_LIB, null);
            if (str == "core_ref") return (TokenCode.CORE_REF, null);
            if (str == "net_ref") return (TokenCode.NET_REF, null);
            if (str == "mono_ref") return (TokenCode.MONO_REF, null);
            if (str == "core_tool") return (TokenCode.CORE_TOOL, null);
            if (str == "net_tool") return (TokenCode.NET_TOOL, null);
            if (str == "mono_tool") return (TokenCode.MONO_TOOL, null);
            if (str == "core_deps") return (TokenCode.CORE_DEPS, null);
            if (str == "net_deps") return (TokenCode.NET_DEPS, null);
            if (str == "mono_deps") return (TokenCode.MONO_DEPS, null);
            if (str == "core_files") return (TokenCode.CORE_FILES, null);
            if (str == "net_files") return (TokenCode.NET_FILES, null);
            if (str == "mono_files") return (TokenCode.MONO_FILES, null);

            throw new UnexpectedToken(str);
        }

        private (TokenCode, string) PeekToken()
        {
            int pos = _pos;
            var result = GetToken();
            _pos = pos;

            return result;
        }

        private (TokenCode, string) GetString()
        {
            ++_pos;
            var q = _pos;

            while (!IsEof() && _toparse[q] != '\"') ++q;
            if (IsEof())
                throw new InvalidOperationException("Expected end of string");

            var result = _toparse.Substring(_pos, q - _pos);
            _pos = q + 1;

            return (TokenCode.STRING, result);
        }

        private bool IsEof()
        {
            return _pos >= _toparse.Length;
        }

        private bool IsWhitespace(char p)
        {
            switch (p)
            {
                case ' ':
                case '\t':
                case '\n':
                case '\r':
                case ',':
                    return true;
            }

            return false;
        }
        private bool IsSeparator(char p)
        {
            switch (p)
            {
                case ' ':
                case '\t':
                case '\n':
                case ',':
                case '(':
                case ')':
                case '[':
                case ']':
                case '=':
                case '\r':
                    return true;
            }

            return false;
        }
        private bool IsWhitespace()
        {
            return IsWhitespace(_toparse[_pos]);
        }
    }
}
