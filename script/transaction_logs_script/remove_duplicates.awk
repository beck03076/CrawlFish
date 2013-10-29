#! /usr/bin/awk -f

BEGIN{
}
{
	if(!($0 in a))
	{
		a[$0];
		print
	}
}
