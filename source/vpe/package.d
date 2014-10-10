module vpe;

public {
	import display = vpe.display;
	import draw = vpe.draw;
	import vpe.clock;
	import vpe.color;
	import vpe.shader;
	import vpe.input;
	import vpe.events;
}

import vpe.internal;

static this() {
	initalizeVPE();
}
static ~this() {
	terminateVPE();
}
