// See LICENSE for license details.

//**************************************************************************
// Median filter (c version)
//--------------------------------------------------------------------------

#define BLOCK 2
#define KSIZE 2
void channel_conv(float* src, float* kern, float* dest, int srcwidth, int srcheight, int channels) {
    int hwidth = 2*KSIZE+BLOCK;
    setvl(channels);
    loadkern(kern, channels);
    for (int ys = 0, ye = hwidth; ye <= srcheight; ys += BLOCK, ye += BLOCK) {
        init(src+ys*srcwidth*channels, channels, srcwidth);
        for (int xs = 0, xe = hwidth, n = 0;
             xe <= srcwidth;
             xs += BLOCK, xe += BLOCK, n = (n+BLOCK)%hwidth) {
            load(src+ys*srcwidth*channels+(xs+hwidth-BLOCK)*channels,
                 dest+(ys+KSIZE)*srcwidth*channels+(KSIZE+xs)*channels,
                 channels,
                 srcwidth,
                 srcwidth,
                 n);
        }
    }
}
