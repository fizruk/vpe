import vpe;
import vpl;

void main() {
	auto clock = new Clock();
	real angle = 0;
	mainloop: while (true) {
		foreach (e; getEvents!KeyDown) {
			if (e.key == Key.Escape) break mainloop;
			if (e.key == Key.Space) angle = 0;
		}
		draw.clear(Color(0.8, 0.8, 1));

		draw.save();
		draw.color(clock.currentTime % 1, 0, 0);
		draw.rotate(angle);
		draw.scale(0.1);
		draw.translate(-0.5, -0.5);
		draw.quad();
		draw.load();

		display.flip();

		angle += clock.tick();
	}
}
