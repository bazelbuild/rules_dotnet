using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace simpleresgen
{
    public class Translator
    {
        public void Translate(string infile, string outfile)
        {
            var writer = new System.Resources.ResourceWriter(outfile);
            using (var inf = File.OpenText(infile))
            {
                var reader = new mono.ResXResourceReader(inf);
                foreach (DictionaryEntry d in reader)
                {
                    writer.AddResource(d.Key.ToString(), d.Value);
                }
            }

            writer.Generate();
            writer.Close();
        }
    }
}
