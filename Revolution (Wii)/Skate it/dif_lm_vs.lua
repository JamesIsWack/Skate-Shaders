GXSetNumChans(0);
GXSetNumTexGens(4);
GXSetTexCoordGen(GX_TEXCOORD0, GX_TG_MTX2x4, GX_TG_TEX0, GX_IDENTITY);		// Diffuse
GXSetTexCoordGen(GX_TEXCOORD1, GX_TG_MTX2x4, GX_TG_TEX1, GX_IDENTITY);		// LM
GXSetTexCoordGen(GX_TEXCOORD2, GX_TG_MTX2x4, GX_TG_POS, GX_TEXMTX8);		// Shadow Plane
GXSetTexCoordGen(GX_TEXCOORD3, GX_TG_MTX3x4, GX_TG_POS, GX_TEXMTX9);		// Shadow Projection