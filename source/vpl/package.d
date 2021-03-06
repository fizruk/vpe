module vpl;

public {
	import vpl.std;
	import vpl.logging;
	import vpl.vector;
	import vpl.matrix;
}

auto sign(T)(T val) {
	if (val < 0) return -1;
	if (val > 0) return +1;
	return 0;
}

auto clamp(T)(T val, T minVal, T maxVal) {
	if (val < minVal) return minVal;
	if (val > maxVal) return maxVal;
	return val;
}

auto random(T : bool)() {
	return randomInc!int(0, 1) == 1;
}
auto random(T)(T lf, T rg) {
	return uniform(lf, rg);
}
auto randomInc(T)(T lf, T rg) {
	return uniform!"[]"(lf, rg);
}

template RangeTuple(int from, int to) {
	static if (from >= to)
		alias TypeTuple!() RangeTuple;
	else
		alias TypeTuple!(from, RangeTuple!(from + 1, to)) RangeTuple;
}
alias RangeTuple(int n) = RangeTuple!(0, n);

auto opBinary(string op, T1, T2)(T1 v1, T2 v2) { return mixin("v1 " ~ op ~ " v2"); }
auto opUnary(string op, T)(T val) { return mixin(op ~ " val"); }
auto opOpAssign(string op, T1, T2)(ref T1 a, T2 b) { return mixin("a " ~ op ~ "= b"); }

template importBinary(string path) {
	const byte[] importBinary = cast(const byte[]) import(path);
}
