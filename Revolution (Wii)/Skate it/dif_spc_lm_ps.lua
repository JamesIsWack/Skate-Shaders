GXSetNumIndStages(2);
GXSetNumTevStages(6);

//
// Shadow Plane
//
GXSetTevDirect(GX_TEVSTAGE0);
GXSetTevKColorSel(GX_TEVSTAGE0, GX_TEV_KCSEL_K2);
GXSetTevOrder(GX_TEVSTAGE0, GX_TEXCOORD3, GX_TEXMAP6, GX_COLOR_NULL);
GXSetTevColorIn(GX_TEVSTAGE0, GX_CC_ZERO, GX_CC_ONE, GX_CC_TEXC, GX_CC_KONST);
GXSetTevColorOp(GX_TEVSTAGE0, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);
GXSetTevAlphaIn(GX_TEVSTAGE0, GX_CA_ZERO, GX_CA_ONE, GX_CA_TEXA, GX_CA_KONST);
GXSetTevAlphaOp(GX_TEVSTAGE0, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);

//
// Shadow Map
//
GXSetTevDirect(GX_TEVSTAGE1);
GXSetTevOrder(GX_TEVSTAGE1, GX_TEXCOORD4, GX_TEXMAP5, GX_COLOR_NULL);
GXSetTevColorIn(GX_TEVSTAGE1, GX_CC_ONE, GX_CC_ZERO, GX_CC_TEXC, GX_CC_CPREV);
GXSetTevColorOp(GX_TEVSTAGE1, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);
GXSetTevAlphaIn(GX_TEVSTAGE1, GX_CA_ONE, GX_CA_ZERO, GX_CA_TEXA, GX_CA_ZERO);
GXSetTevAlphaOp(GX_TEVSTAGE1, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);


//
// LM (with blend between shadowmap and dark color)
//
GXSetTevKColorSel(GX_TEVSTAGE2, GX_TEV_KCSEL_K3);
GXSetIndTexOrder(GX_INDTEXSTAGE0, GX_TEXCOORD1, GX_TEXMAP1);
GXSetIndTexCoordScale(GX_INDTEXSTAGE0, GX_ITS_1, GX_ITS_1); 
GXSetTevOrder(GX_TEVSTAGE2, GX_TEXCOORD_NULL, GX_TEXMAP7, GX_COLOR_NULL);
GXSetTevColorIn(GX_TEVSTAGE2, GX_CC_KONST, GX_CC_TEXC, GX_CC_CPREV, GX_CC_ZERO);
GXSetTevColorOp(GX_TEVSTAGE2, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVREG2);
GXSetTevAlphaIn(GX_TEVSTAGE2, GX_CA_ZERO, GX_CA_ZERO, GX_CA_ZERO, GX_CA_ONE);
GXSetTevAlphaOp(GX_TEVSTAGE2, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVREG2);

//
// Per-Pixel Specular (based on Normal + screen-space offset in spec texture)
//
GXSetIndTexOrder(GX_INDTEXSTAGE1, GX_TEXCOORD5, GX_TEXMAP4);
//GXSetIndTexCoordScale(GX_INDTEXSTAGE1, GX_ITS_2, GX_ITS_2); 
GXSetIndTexCoordScale(GX_INDTEXSTAGE1, GX_ITS_1, GX_ITS_1); 
GXSetTevOrder(GX_TEVSTAGE3, GX_TEXCOORD6, GX_TEXMAP2, GX_COLOR_NULL);
GXSetTevColorIn(GX_TEVSTAGE3, GX_CC_ZERO, GX_CC_ZERO, GX_CC_ZERO, GX_CC_TEXC);
GXSetTevColorOp(GX_TEVSTAGE3, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);
GXSetTevAlphaIn(GX_TEVSTAGE3, GX_CA_ZERO, GX_CA_ZERO, GX_CA_ZERO, GX_CA_TEXA);
GXSetTevAlphaOp(GX_TEVSTAGE3, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);

//
// DIFFUSE * LM
//
GXSetTevDirect(GX_TEVSTAGE4);
GXSetTevOrder(GX_TEVSTAGE4, GX_TEXCOORD0, GX_TEXMAP0, GX_COLOR_NULL);
GXSetTevColorIn(GX_TEVSTAGE4, GX_CC_ZERO, GX_CC_C2, GX_CC_TEXC, GX_CC_ZERO);
GXSetTevColorOp(GX_TEVSTAGE4, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_2, GX_FALSE, GX_TEVREG2);
GXSetTevAlphaIn(GX_TEVSTAGE4, GX_CA_ZERO, GX_CA_ZERO, GX_CA_ZERO, GX_CA_TEXA);
GXSetTevAlphaOp(GX_TEVSTAGE4, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVREG2);

//
// (SPEC * SPECMASK) + (DIFFUSE * LM)
//
GXSetTevDirect(GX_TEVSTAGE5);
GXSetTevOrder(GX_TEVSTAGE5, GX_TEXCOORD2, GX_TEXMAP3, GX_COLOR_NULL);
GXSetTevColorIn(GX_TEVSTAGE5, GX_CC_ZERO, GX_CC_APREV, GX_CC_TEXC, GX_CC_C2);
GXSetTevColorOp(GX_TEVSTAGE5, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);
GXSetTevAlphaIn(GX_TEVSTAGE5, GX_CA_ZERO, GX_CA_ZERO, GX_CA_ZERO, GX_CA_A2);
GXSetTevAlphaOp(GX_TEVSTAGE5, GX_TEV_ADD, GX_TB_ZERO, GX_CS_SCALE_1, GX_TRUE, GX_TEVPREV);
