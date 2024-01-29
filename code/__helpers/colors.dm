// Taken from Jeremy "Spuzzum" Gibson's s_html library.
// http://www.byond.com/developer/Spuzzum/s_html

/proc/color_matrix_identity()
	return list(1,0,0,0, 0,1,0,0, 0,0,1,0, 0,0,0,1, 0,0,0,0)

/proc/random_color()
	return rgb(rand(0,255),rand(0,255),rand(0,255))

/proc/blend_colors(color_01, color_02, power = 0.5)
	power = clamp(power,0,1)
	var/new_red = GETREDPART(color_01) * (1-power) + GETREDPART(color_02)*power
	var/new_green = GETGREENPART(color_01)*(1-power) + GETGREENPART(color_02)*power
	var/new_blue = GETBLUEPART(color_01)*(1-power) + GETBLUEPART(color_02)*power
	return rgb(new_red,new_green,new_blue)


/*
/proc/blend_colors(var/color_01,var/color_02,var/power = 0.5)
	power = clamp(power,0,1)
	var/new_red = GETREDPART(color_01) + GETREDPART(color_02)*power
	var/new_green = GETGREENPART(color_01) + GETGREENPART(color_02)*power
	var/new_blue = GETBLUEPART(color_01) + GETBLUEPART(color_02)*power
	var/mod = max(1,max(new_red,new_green,new_blue)/255) //Normalize if needed.
	return rgb(new_red/mod,new_green/mod,new_blue/mod)
*/
