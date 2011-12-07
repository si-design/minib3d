#include "geom.h"
#include <iostream>
#include <map>

using namespace std;

extern "C"{
	void C_UpdateNormals(int,int,short *,float *,float *);
	int C_IntersectSegmentTriangle(	float px, float py, float pz, 
									float qx, float qy, float qz, 
									float ax, float ay, float az, 
									float bx, float by, float bz, 
									float cx, float cy, float cz,
	                             	float &u, float &v, float &w, float &t);
}

int TriangleVertex(int,int,short*);

void C_UpdateNormals(int no_tris,int no_verts,short *tris,float *vert_coords,float *vert_norm){

	int t;
	map<Vector,Vector> norm_map;

	for( t=0;t<no_tris;++t ){

		int tri_no=(t+1)*3;
		
		int v0=tris[tri_no-3];
		int v1=tris[tri_no-2];
		int v2=tris[tri_no-1];

		float ax=vert_coords[v1*3+0]-vert_coords[v0*3+0];
		float ay=vert_coords[v1*3+1]-vert_coords[v0*3+1];
		float az=vert_coords[v1*3+2]-vert_coords[v0*3+2];

		float bx=vert_coords[v2*3+0]-vert_coords[v1*3+0];
		float by=vert_coords[v2*3+1]-vert_coords[v1*3+1];
		float bz=vert_coords[v2*3+2]-vert_coords[v1*3+2];

		float nx=(ay*bz)-(az*by); // surf.TriangleNX#(t)
		float ny=(az*bx)-(ax*bz); // surf.TriangleNX#(t)
		float nz=(ax*by)-(ay*bx); // surf.TriangleNX#(t)
	
		Vector n(nx,ny,nz);
		n.normalize();

		int c;
		for( c=0;c<3;++c ){

			int v=TriangleVertex(t,c,tris);
			
			float vx=vert_coords[v*3]; // surf.VertexX(v) 
			float vy=vert_coords[(v*3)+1]; // surf.VertexY(v)
			float vz=vert_coords[(v*3)+2]; // surf.VertexZ(v)
		
			Vector vex;
			vex.x=vx;
			vex.y=vy;
			vex.z=vz;

			norm_map[vex]+=n;

		}
		
	}

	int v;
	for( v=0;v<no_verts;++v ){
	
		float vx=vert_coords[v*3]; // surf.VertexX(v)
		float vy=vert_coords[(v*3)+1]; // surf.VertexY(v)
		float vz=vert_coords[(v*3)+2]; // surf.VertexZ(v)
		
		Vector vert(vx,vy,vz);
		//vert.x=vx;
		//vert.y=vy;
		//vert.z=vz;
		
		Vector norm=norm_map[vert];
		//If !norm Continue;
		
		norm.normalize();
		
		vert_norm[v*3+0]=norm.x; // surf.VertexNormal(v,norm.x,norm.y,norm.z)
		vert_norm[v*3+1]=norm.y; // surf.VertexNormal(v,norm.x,norm.y,norm.z)
		vert_norm[v*3+2]=norm.z; // surf.VertexNormal(v,norm.x,norm.y,norm.z)
	
	}
	


}

int TriangleVertex(int tri_no,int corner,short* tris){
	
	int vid[3];
	
	tri_no=(tri_no+1)*3;
	vid[0]=tris[tri_no-1];
	vid[1]=tris[tri_no-2];
	vid[2]=tris[tri_no-3];
		
	return vid[corner];
	
}

// Given segment pq and triangle abc, returns whether segment intersects
// triangle and if so, also returns the barycentric coordinates (u,v,w)
// of the intersection point
int C_IntersectSegmentTriangle(	float px, float py, float pz, 
								float qx, float qy, float qz, 
								float ax, float ay, float az, 
								float bx, float by, float bz, 
								float cx, float cy, float cz,
                             	float &u, float &v, float &w, float &t)
{
	Vector p,q,a,b,c;
	p.x=px;p.y=py;p.z=pz;q.x=qx,q.y=qy;q.z=qz;a.x=ax;a.y=ay;a.z=az;b.x=bx;b.y=by;b.z=bz;c.x=cx;c.y=cy;c.z=cz;

    Vector ab = b - a;
    Vector ac = c - a;
    Vector qp = p - q;

    // Compute triangle normal. Can be precalculated or cached if
    // intersecting multiple segments against the same triangle
    Vector n = ab.cross(ac);

    // Compute denominator d. If d <= 0, segment is parallel to or points
    // away from triangle, so exit early
    float d = qp.dot(n);
    if (d <= 0.0f) return 0;

    // Compute intersection t value of pq with plane of triangle. A ray
    // intersects iff 0 <= t. Segment intersects iff 0 <= t <= 1. Delay
    // dividing by d until intersection has been found to pierce triangle
    Vector ap = p - a;
    t = ap.dot(n);
    if (t < 0.0f) return 0;
    if (t > d) return 0; // For segment; exclude this code line for a ray test

    // Compute barycentric coordinate components and test if within bounds
    Vector e = qp.cross(ap);
    v = ac.dot(e);
    if (v < 0.0f || v > d) return 0;
    w = -(ab.dot(e));
    if (w < 0.0f || v + w > d) return 0;

    // Segment/ray intersects triangle. Perform delayed division and
    // compute the last barycentric coordinate component
    float ood = 1.0f / d;
    t *= ood;
    v *= ood;
    w *= ood;
    u = 1.0f - v - w;
    return 1;
}
