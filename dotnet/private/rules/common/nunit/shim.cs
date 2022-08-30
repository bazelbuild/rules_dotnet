internal static class NUnitShim {
		public static int Main(string[] args) => new NUnitLite.AutoRun().Execute(args);
}
