#include "collision.h"

bool Collision::update( const Line &line,float t,const Vector &n ){

//	if( t<0 || t>time ) return false;

	if( t>time ) return false;
	Plane p(line*t,n);
	if( p.n.dot( line.d )>=0 ) return false;
	if( p.distance(line.o)<-COLLISION_EPSILON ) return false;

	time=t;
	normal=n;
	return true;
}

bool Collision::sphereCollide( const Line &line,float radius,const Vector &dest,float dest_radius ){

	radius+=dest_radius;
	Line l( line.o-dest,line.d );

	float a=l.d.dot(l.d);
	if( !a ) return false;
	float b=l.o.dot(l.d)*2;
	float c=l.o.dot(l.o)-radius*radius;
	float d=b*b-4*a*c;
	if( d<0 ) return false;

	float t1=(-b+sqrt(d))/(2*a);
	float t2=(-b-sqrt(d))/(2*a);

	float t=t1<t2 ? t1 : t2;

	if( t>time ) return false;

	return update( line,t,(l*t).normalized() );
}

//v0,v1 = edge verts
//pn = poly normal
//en = edge normal
static bool edgeTest( const Vector &v0,const Vector &v1,const Vector &pn,const Vector &en,const Line &line,float radius,Collision *curr_coll ){

	Matrix tm=~Matrix( en,(v1-v0).normalized(),pn );
	Vector sv=tm*(line.o-v0),dv=tm*(line.o+line.d-v0);
	Line l( sv,dv-sv );
	//do cylinder test...
	float a,b,c,d,t1,t2,t;
	a=(l.d.x*l.d.x+l.d.z*l.d.z);
	if( !a ) return false;					//ray parallel to cylinder
	b=(l.o.x*l.d.x+l.o.z*l.d.z)*2;
	c=(l.o.x*l.o.x+l.o.z*l.o.z)-radius*radius;
	d=b*b-4*a*c;
	if( d<0 ) return false;					//ray misses cylinder
	t1=(-b+sqrt(d))/(2*a);
	t2=(-b-sqrt(d))/(2*a);
	t=t1<t2 ? t1 : t2;
	if( t>curr_coll->time ) return false;	//intersects too far away
	Vector i=l*t,p;
	if( i.y>v0.distance(v1) ) return false;	//intersection above cylinder
	if( i.y>=0 ){
		p.y=i.y;
	}else{
		//below bottom of cylinder...do sphere test...
		a=l.d.dot(l.d);
		if( !a ) return false;				//ray parallel to sphere
		b=l.o.dot(l.d)*2;
		c=l.o.dot(l.o)-radius*radius;
		d=b*b-4*a*c;
		if( d<0 ) return false;				//ray misses sphere
		t1=(-b+sqrt(d))/(2*a);
		t2=(-b-sqrt(d))/(2*a);
		t=t1<t2 ? t1 : t2;
		if( t>curr_coll->time ) return false;
		i=l*t;
	}

	return curr_coll->update( line,t,(~tm*(i-p)).normalized() );
}

bool Collision::triangleCollide( const Line &line,float radius,const Vector &v0,const Vector &v1,const Vector &v2 ){

	//triangle plane
	Plane p( v0,v1,v2 );
	if( p.n.dot( line.d )>=0 ) return false;

	//move plane out
	p.d-=radius;
	float t=p.t_intersect( line );
	if( t>time ) return false;

	//edge planes
	Plane p0( v0+p.n,v1,v0 ),p1( v1+p.n,v2,v1 ),p2( v2+p.n,v0,v2 );

	//intersects triangle?
	Vector i=line*t;
	if( p0.distance(i)>=0 && p1.distance(i)>=0 && p2.distance(i)>=0 ){
		return update( line,t,p.n );
	}

	if( radius<=0 ) return false;

	return
	edgeTest( v0,v1,p.n,p0.n,line,radius,this )|
	edgeTest( v1,v2,p.n,p1.n,line,radius,this )|
	edgeTest( v2,v0,p.n,p2.n,line,radius,this );
}

bool Collision::boxCollide( const Line &line,float radius,const Box &box ){

	static int quads[]={
		2,3,1,0,
		3,7,5,1,
		7,6,4,5,
		6,2,0,4,
		6,7,3,2,
		0,1,5,4
	};

	bool hit=false;

	for( int n=0;n<24;n+=4 ){
		Vector
		v0( box.corner( quads[n] ) ),
		v1( box.corner( quads[n+1] ) ),
		v2( box.corner( quads[n+2] ) ),
		v3( box.corner( quads[n+3] ) );

		//quad plane
		Plane p( v0,v1,v2 );
		if( p.n.dot( line.d )>=0 ) continue;
		
		//move plane out
		p.d-=radius;
		float t=p.t_intersect( line );
		if( t>time ) return false;

		//edge planes
		Plane
			p0( v0+p.n,v1,v0 ),
			p1( v1+p.n,v2,v1 ),
			p2( v2+p.n,v3,v2 ),
			p3( v3+p.n,v0,v3 );

		//intersects triangle?
		Vector i=line*t;
		if( p0.distance(i)>=0 && p1.distance(i)>=0 && p2.distance(i)>=0 && p3.distance(i)>=0 ){
			hit|=update( line,t,p.n );
			continue;
		}

		if( radius<=0 ) continue;

		hit|=
		edgeTest( v0,v1,p.n,p0.n,line,radius,this )|
		edgeTest( v1,v2,p.n,p1.n,line,radius,this )|
		edgeTest( v2,v3,p.n,p2.n,line,radius,this )|
		edgeTest( v3,v0,p.n,p3.n,line,radius,this );
	}
	return hit;
}


struct CollisionInfo{

	Vector dv;
	Vector sv;
	Vector radii;

	Vector panic;

	Transform y_tform;
	
	float radius,inv_y_scale;
	float y_scale;

	int n_hit;
	Plane planes[2];

	Line coll_line;
	Vector dir;
	
	float td;
	float td_xz;
	
	int hits;
	
	float dst_radius;
	float ax;
	float ay;
	float az;
	float bx;
	float by;
	float bz;
};


// start of wrapper funcs

extern "C"{

	Vector* C_CreateVecObject(float x,float y,float z);
	void C_DeleteVecObject(Vector* vec);
	void C_UpdateVecObject(Vector &vec,float x,float y,float z);
	float C_VecX(Vector* vec);
	float C_VecY(Vector* vec);
	float C_VecZ(Vector* vec);
	
	Line* C_CreateLineObject(float ox,float oy,float oz,float dx,float dy,float dz);
	void C_UpdateLineObject(Line* line,float ox,float oy,float oz,float dx,float dy,float dz);
	void C_DeleteLineObject(Line* line);
	
	Matrix* C_CreateMatrixObject(Vector &vec_i,Vector &vec_j,Vector &vec_k);
	void C_UpdateMatrixObject(Matrix &mat,Vector &vec_i,Vector &vec_j,Vector &vec_k);
	void C_DeleteMatrixObject(Matrix* matrix);
	
	Transform* C_CreateTFormObject(Matrix &mat,Vector &vec);
	void C_UpdateTFormObject(Transform* tform,Matrix* mat,Vector* vec);
	void C_DeleteTFormObject(Transform* tform);
	
	CollisionInfo* C_CreateCollisionInfoObject(Vector &dv,Vector &sv,Vector &radii);
	void C_UpdateCollisionInfoObject(CollisionInfo* ci,float dst_radius,float ax,float ay,float az,float bx,float by,float bz);
	void C_DeleteCollisionInfoObject(CollisionInfo* ci);
	
	Collision* C_CreateCollisionObject();
	void C_DeleteCollisionObject(Collision* col);
	
	int C_CollisionDetect(CollisionInfo &ci,Collision &coll,Transform &dst_tform,MeshCollider* mesh_col,int method);
	int C_CollisionResponse(CollisionInfo &ci,Collision &coll,int response);
	int C_CollisionFinal(CollisionInfo &ci);
	
	int C_Pick(CollisionInfo &ci,const Line &line,float radius,Collision &coll,Transform &dst_tform,MeshCollider* mesh_col,int pick_geom);
	
	float C_CollisionPosX();
	float C_CollisionPosY();
	float C_CollisionPosZ();
	float C_CollisionX();
	float C_CollisionY();
	float C_CollisionZ();
	float C_CollisionNX();
	float C_CollisionNY();
	float C_CollisionNZ();
	float C_CollisionTime();
	int C_CollisionSurface();
	int C_CollisionTriangle();
	
}


// globals
const int MAX_HITS=10;

Vector col_coords;
Vector col_normal;
int col_time;
int col_surface;
int col_index;	
Vector col_pos;

Collision* C_CreateCollisionObject()
{
	Collision* col=new Collision;

	return col;
}

void C_DeleteCollisionObject(Collision* col)
{
	delete col;
}

CollisionInfo* C_CreateCollisionInfoObject(Vector &dv,Vector &sv,Vector &radii)
{
	CollisionInfo* ci=new CollisionInfo();

	ci->dv=dv;
	ci->sv=sv;
	ci->radii=radii;
	
	//
	
	ci->panic=ci->sv;
	
	ci->radius=ci->radii.x;
	
	ci->y_scale=ci->inv_y_scale=ci->y_tform.m.j.y=1;

	if( ci->radii.x!=ci->radii.y ){
		ci->y_scale=ci->y_tform.m.j.y=ci->radius/ci->radii.y;
		ci->inv_y_scale=1/ci->y_scale;
		ci->sv.y*=ci->y_scale;
		ci->dv.y*=ci->y_scale;
	}

	Line coll_line( ci->sv,ci->dv-ci->sv );
	ci->coll_line=coll_line;
	
	ci->dir=ci->coll_line.d;

	ci->td=ci->coll_line.d.length();
	ci->td_xz=Vector( ci->coll_line.d.x,0,ci->coll_line.d.z ).length();

	//
	
	ci->hits=0;
	
	//
	
	ci->dst_radius=1.0;
	ci->ax=1.0;
	ci->ay=1.0;
	ci->az=1.0;
	ci->bx=1.0;
	ci->by=1.0;
	ci->bz=1.0;

	return ci;	
}

void C_UpdateCollisionInfoObject(CollisionInfo* ci,float dst_radius,float ax,float ay,float az,float bx,float by,float bz)
{
	ci->dst_radius=dst_radius;
	ci->ax=ax;
	ci->ay=ay;
	ci->az=az;
	ci->bx=bx;
	ci->by=by;
	ci->bz=bz;
}

void C_DeleteCollisionInfoObject(CollisionInfo* ci)
{
	delete ci;
}

bool hitTest( const Line &line,float radius,const Transform &tf,MeshCollider* mesh_col,int method,Collision* curr_coll,CollisionInfo &ci  ){
	switch( method ){

	case COLLISION_METHOD_SPHERE:
		return curr_coll->sphereCollide( line,radius,tf.v,ci.dst_radius );

	case COLLISION_METHOD_POLYGON:
		return mesh_col->collide( line,radius,tf,curr_coll );

	case COLLISION_METHOD_BOX:
		Transform t=tf;
		t.m.i.normalize();t.m.j.normalize();t.m.k.normalize();
		
		Vector a(ci.ax,ci.ay,ci.az);
		Vector b(ci.bx,ci.by,ci.bz);
		Box box(a,b);
		
		if( curr_coll->boxCollide( ~t*line,radius,box ) ){
			curr_coll->normal=t.m*curr_coll->normal;
			return true;
		}

	}
	return false;
}

int C_CollisionDetect(CollisionInfo &ci,Collision &coll,Transform &dst_tform,MeshCollider* mesh_col,int method){

	int hit=0;
	if( ci.y_scale==1 ){
		if( hitTest(ci.coll_line,ci.radius,dst_tform,mesh_col,method,&coll,ci ) ){
		
			hit=true;
			col_normal=coll.normal;
			col_time=coll.time;
			col_surface=coll.surface;
			col_index=(int)coll.index;		
		}	
	}else{
		if( hitTest(ci.coll_line,ci.radius,ci.y_tform * dst_tform,mesh_col,method,&coll,ci ) ){
		
			hit=true;
			col_normal=coll.normal;
			col_time=coll.time;
			col_surface=coll.surface;
			col_index=(int)coll.index;	
		}
	}
	return hit;
}

int C_CollisionResponse(CollisionInfo &ci,Collision &coll,int response){

	col_coords=ci.coll_line*coll.time-coll.normal*ci.radii.x;
	col_coords.y*=ci.y_scale;
	
	//register collision
	if( ++ci.hits==MAX_HITS ){
		return false;
	}

	Plane coll_plane( ci.coll_line*coll.time,coll.normal );

	coll_plane.d-=COLLISION_EPSILON;
	coll.time=coll_plane.t_intersect( ci.coll_line );

	if( coll.time>0 ){// && fabs(coll.normal.dot( coll_line.d ))>EPSILON ){
		//update source position - ONLY if AHEAD!
		ci.sv=ci.coll_line*coll.time;
		ci.td*=1-coll.time;
		ci.td_xz*=1-coll.time;
	}

	if( response==COLLISION_RESPONSE_STOP ){
		ci.dv=ci.sv;
		return false;
	}

	//find nearest point on plane to dest
	Vector nv=coll_plane.nearest( ci.dv );

	if( ci.n_hit==0 ){
		ci.dv=nv;
	}else if( ci.n_hit==1 ){
		if( ci.planes[0].distance(nv)>=0 ){
			ci.dv=nv;ci.n_hit=0;
		}else if( fabs( ci.planes[0].n.dot( coll_plane.n ) )<1-EPSILON ){
			ci.dv=coll_plane.intersect( ci.planes[0] ).nearest( ci.dv );
		}else{
			//SQUISHED!
			//Exit(0);
			ci.hits=MAX_HITS;return false;
		}
	}else if( ci.planes[0].distance(nv)>=0 && ci.planes[1].distance(nv)>=0 ){
		ci.dv=nv;ci.n_hit=0;
	}else{
		ci.dv=ci.sv;return false;
	}

	Vector dd( ci.dv-ci.sv );

	//going behind initial direction? really necessary?
	if( dd.dot( ci.dir )<=0 ){ ci.dv=ci.sv;return false; }

	if( response==COLLISION_RESPONSE_SLIDE ){
		float d=dd.length();
		if( d<=EPSILON ){ ci.dv=ci.sv;return false; }
		if( d>ci.td ) dd*=ci.td/d;
	}else if( response==COLLISION_RESPONSE_SLIDEXZ ){
		float d=Vector( dd.x,0,dd.z ).length();
		if( d<=EPSILON ){ ci.dv=ci.sv;return false; }
		if( d>ci.td_xz ) dd*=ci.td_xz/d;
	}

	ci.coll_line.o=ci.sv;
	ci.coll_line.d=dd;ci.dv=ci.sv+dd;
	ci.planes[ci.n_hit++]=coll_plane;
	
	return true;
}

int C_CollisionFinal(CollisionInfo &ci)
{
	if( ci.hits ){
		if( ci.hits<MAX_HITS ){
			ci.dv.y*=ci.inv_y_scale;
			col_pos=ci.dv;
		}else{
			col_pos=ci.panic;
		}
		return true;
	}
	return false;
}

int C_Pick(CollisionInfo &ci,const Line &line,float radius,Collision &coll,Transform &dst_tform,MeshCollider* mesh_col,int pick_geom){

	int hit=false;

	if( hitTest(line,radius,dst_tform,mesh_col,pick_geom,&coll,ci ) ){
		
		hit=true;
		col_normal=coll.normal;
		col_time=coll.time;
		col_surface=coll.surface;
		col_index=(int)coll.index;	
		
		col_coords=line*coll.time-coll.normal*radius;	
	}
	
	//if(hit)
	//{
	//	col_coords=line*coll.time-coll.normal*radius;
	//}

	return hit;
}

float C_CollisionPosX()
{
	return col_pos.x;
}

float C_CollisionPosY()
{
	return col_pos.y;
}

float C_CollisionPosZ()
{
	return col_pos.z;
}

float C_CollisionX()
{
	return col_coords.x;
}

float C_CollisionY()
{
	return col_coords.y;
}

float C_CollisionZ()
{
	return col_coords.z;
}

float C_CollisionNX()
{
	return col_normal.x;
}

float C_CollisionNY()
{
	return col_normal.y;
}

float C_CollisionNZ()
{
	return col_normal.z;
}

float C_CollisionTime()
{
	return col_time;
}

int C_CollisionSurface()
{
	return col_surface;
}

int C_CollisionTriangle()
{
	return col_index;
}

Vector* C_CreateVecObject(float x,float y,float z)
{
	Vector* vec=new Vector(x,y,z);
	
	return vec;
}

void C_DeleteVecObject(Vector* vec)
{
	delete vec;
}

void C_UpdateVecObject(Vector& vec,float x,float y,float z)
{
	vec.x=x;
	vec.y=y;
	vec.z=z;
}

float C_VecX(Vector* vec)
{
	return vec->x;
}

float C_VecY(Vector* vec)
{
	return vec->y;
}

float C_VecZ(Vector* vec)
{
	return vec->z;
}

Line* C_CreateLineObject(float ox,float oy,float oz,float dx,float dy,float dz)
{
	Vector o(ox,oy,oz);
	Vector d(dx,dy,dz);

	Line* line=new Line(o,d);
	
	return line;
}

void C_DeleteLineObject(Line* line)
{
	delete line;
}

void C_UpdateLineObject(Line* line,float ox,float oy,float oz,float dx,float dy,float dz)
{
	line->o.x=ox;
	line->o.y=oy;
	line->o.z=oz;
	line->d.x=dx;
	line->d.y=dy;
	line->d.z=dz;
}

Matrix* C_CreateMatrixObject(Vector &vec_i,Vector &vec_j,Vector &vec_k)
{
	Matrix* mat=new Matrix(vec_i,vec_j,vec_k);
	
	return mat;
}

void C_UpdateMatrixObject(Matrix& mat,Vector &vec_i,Vector &vec_j,Vector &vec_k)
{
	mat.i=vec_i;
	mat.j=vec_j;
	mat.k=vec_k;
}

void C_DeleteMatrixObject(Matrix* mat)
{
	delete mat;
}

Transform* C_CreateTFormObject(Matrix &mat,Vector &vec_v)
{
	Transform* tform=new Transform(mat,vec_v);
	
	return tform;
}

void C_UpdateTFormObject(Transform* tform,Matrix* mat,Vector* vec_v)
{
	C_UpdateMatrixObject(tform->m,mat->i,mat->j,mat->k);
	C_UpdateVecObject(tform->v,vec_v->x,vec_v->y,vec_v->z);
}

void C_DeleteTFormObject(Transform* tform)
{
	delete tform;
}

// end of wrapper funcs