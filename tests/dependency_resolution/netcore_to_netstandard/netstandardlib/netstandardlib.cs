namespace NetstandardLib
{
    public static class NetstandardLib
    {
        public static string GetCompileTimeFramework()
        {
#if NETSTANDARD2_1
            return "netstandard2.1";
#else
            return "wrong";
#endif
        }
    }
}
