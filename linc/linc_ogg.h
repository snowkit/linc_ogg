#ifndef _LINC_OGG_IMAGE_H_
#define _LINC_OGG_IMAGE_H_

#include "ogg/ogg.h"
#include "vorbis/vorbisfile.h"

#include <hxcpp.h>

namespace linc {

    namespace ogg {

        typedef ::cpp::Pointer<OggVorbis_File> OggFile;

        extern OggFile newOggVorbisFile();
        extern Dynamic ov_comment(OggFile vf, int link);
        extern int ov_read(OggFile vf, Array<unsigned char> buffer, int length, int bigendianp, int word, int sgned);

    } //ogg namespace

} //linc

#endif //_LINC_OGG_IMAGE_H_
