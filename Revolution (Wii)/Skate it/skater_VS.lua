GXSetNumChans(1);

GXSetChanCtrl(
	GX_COLOR0,
	GX_ENABLE,
	GX_SRC_REG,
	GX_SRC_REG,
	GX_LIGHT0,
	GX_DF_CLAMP,
	GX_AF_NONE);

					GXSetChanCtrl(	GX_ALPHA0,
							GX_ENABLE,
							GX_SRC_REG,
							GX_SRC_REG,
							GX_LIGHT1,
							GX_DF_CLAMP,
							GX_AF_NONE);


GXSetNumTexGens(1);
GXSetTexCoordGen(GX_TEXCOORD0, GX_TG_MTX2x4, GX_TG_TEX0, GX_IDENTITY);