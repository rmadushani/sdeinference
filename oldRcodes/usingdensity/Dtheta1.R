Dtheta1 <- function(xvec,yvec,h,driftfun,difffun1,c0)
{
	G = integrandmat(xvec,yvec,h,driftfun,difffun1,c0)
 	# diffmat = diffgandf(c0,xvec)
	nn = length(xvec)
        mm = length(yvec)
	X=replicate(mm,xvec)
 	Y=t(replicate(nn,yvec))
	internpart1 = (X-Y-driftfun(c0,Y)*h)
	# internpart2 = replicate(nn,diffmat[,3])
	internpart2 = diffdiffustheta1(c0,xvec,yvec)
	part1 = -internpart2/difffun1(c0,Y)
	# part2 = difffun1(c0,Y)*internpart1*replicate(nn,diffmat[,1])
	part2 = difffun1(c0,Y)*internpart1*diffdrifttheta1(c0,xvec,yvec)
	part3 = internpart1^2*internpart2
	# OLD ONE: part4 = difffun1(c0,Y)^3*h
	part4 = difffun1(c0,Y)^3
	out = G*(part1+(part2+part3)/part4)
 	return(out)
}
