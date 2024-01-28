#define RECT_TURFS(H_RADIUS, V_RADIUS, CENTER) \
	block( \
	locate(max((CENTER).x-(H_RADIUS),1), max((CENTER).y-(V_RADIUS),1), (CENTER).z), \
	locate(min((CENTER).x+(H_RADIUS),world.maxx), min((CENTER).y+(V_RADIUS),world.maxy), (CENTER).z) \
	)
