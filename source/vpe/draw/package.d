/**
 * Rendering primitives and render state manipulation
 */
module vpe.draw;

public {
	import vpe.draw.transform;
	import vpe.draw.area;
	import vpe.draw.primitives;
}

import vpe.internal;

/// Clear rendering area using specified color
void clear(real r, real g, real b, real a = 1) {
	glClearColor(r, g, b, a);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}
/// ditto
void clear(Color color) { clear(color.r, color.g, color.b, color.a); }

/// Set rendering color
void color(Color color) {
	renderState.color = color;
}
/// ditto
void color(real r, real g, real b, real a = 1) {
	renderState.color = Color(r, g, b, a);
}

/// Save rendering state (push to stack)
void save() { saveRenderState(); }
/// Load rendering state (pop from stack)
void load() { loadRenderState(); }

/// Begin rendering to the texture
void beginTexture(Texture texture) { beginTarget(texture); }
/// End rendering to the texture
void endTexture() { endTarget(); }

/// Get rendering area size
vec2i size() {
	if (renderAreaSizeStack.length == 0) {
		if (currentTarget is null)
			return display.size;
		return currentTarget.size;
	}
	return renderAreaSizeStack[$ - 1];
}

/// Default rendering font
Font font;

/// Measure text using default font
auto measureText(string text) { return font.measure(text); }

/**
 * Render text using default font
 * Params:
 *	text = Text to render
 *	ax = horizontal alignment
 *	ay = vertical alignment
 */
void text(string text, real ax, real ay = 0) {
	font.render(text, ax, ay);
}
/// ditto
void text(string text) {
	font.render(text);
}

/// Get rendering area width
auto width() { return size.x; }

/// Get rendering area height
auto height() { return size.y; }

/// Get rendering area aspect
auto aspect() { return cast(real) width / height; }

private bool _depthTesting = false;

/// Enable or disable depthTesting (3d-mode)
bool depthTesting() { return _depthTesting; }
/// ditto
void depthTesting(bool value) {
	_depthTesting = value;
	if (value) glEnable(GL_DEPTH_TEST);
	else glDisable(GL_DEPTH_TEST);
}
