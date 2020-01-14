using System;

namespace ClassLibrary
{
    public class Specification
    {
        public string Name {get; private set;}
        public string Value {get; private set;}
        public Specification(string name, string value)
        {
            this.Name = name;
            this.Value = value;
        }
    }
}
