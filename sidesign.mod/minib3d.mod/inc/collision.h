#ifndef COLLISION_H
#define COLLISION_H

#include "std.h"

#include "geom.h"
#include "tree.h"

//#include <brl.mod/blitz.mod/blitz.h>

const float COLLISION_EPSILON=.001f;

//collision methods
enum{
	COLLISION_METHOD_SPHERE=1,
	COLLISION_METHOD_POLYGON=2,
	COLLISION_METHOD_BOX=3
};

//collision actions
enum{
	COLLISION_RESPONSE_NONE=0,
	COLLISION_RESPONSE_STOP=1,
	COLLISION_RESPONSE_SLIDE=2,
	COLLISION_RESPONSE_SLIDEXZ=3,
};

struct Collision{

	float time;
	Vector normal;
	int surface;
	int index;

	Collision():time(1){}

	//Collision():time(1),surface(0),index(~0){}

	bool update( const Line &line,float time,const Vector &normal );

	bool sphereCollide( const Line &src_line,float src_radius,const Vector &dest,float dest_radius );
	bool sphereCollide( const Line &line,float radius,const Vector &dest,const Vector &radii );

	bool triangleCollide( const Line &src_line,float src_radius,const Vector &v0,const Vector &v1,const Vector &v2 );

	bool boxCollide( const Line &src_line,float src_radius,const Box &box );
};



#endif