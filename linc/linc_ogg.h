#ifndef _LINC_OGG_IMAGE_H_
#define _LINC_OGG_IMAGE_H_

#include "ogg/ogg.h"
#include "vorbis/vorbisfile.h"

#include <hxcpp.h>

namespace linc {

    namespace ogg {

        extern ::cpp::Pointer<OggVorbis_File> newOggVorbisFile();
        extern Dynamic ov_comment(::cpp::Pointer<OggVorbis_File> vf, int link);

    } //ogg namespace

} //linc

#endif //_LINC_OGG_IMAGE_H_
