#ifndef _LINC_OGG_IMAGE_H_
#define _LINC_OGG_IMAGE_H_

#include "ogg/ogg.h"
#include "vorbis/vorbisfile.h"

#include <hxcpp.h>

namespace linc {

    namespace ogg {

        typedef ::cpp::Pointer<OggVorbis_File> OggFile;
        typedef Array<unsigned char> OggBytesData;

            extern OggFile newOggVorbisFile();
            extern Dynamic ov_comment(OggFile vf, int link);
            extern int ov_read(OggFile vf, OggBytesData buffer, int length, int bigendianp, int word, int sgned);
            extern int ov_open_callbacks(OggBytesData src, OggFile vf, OggBytesData initial, int ibytes, int callback_id);

        //internal

            typedef ::cpp::Function < Void() > InternalReadFN;
            typedef ::cpp::Function < Void() > InternalSeekFN;
            typedef ::cpp::Function < Void() > InternalCloseFN;
            typedef ::cpp::Function < Void() > InternalTellFN;

            extern void init_callbacks(
                InternalReadFN _read_fn,
                InternalSeekFN _seek_fn,
                InternalCloseFN _close_fn,
                InternalTellFN _tell_fn
            );

            static size_t ogg_read_func(void* ptr, size_t size, size_t nmemb, void* userdata);
            static int ogg_seek_func(void* userdata, ogg_int64_t offset, int whence);
            static int ogg_close_func(void* userdata);
            static long ogg_tell_func(void* userdata);

    } //ogg namespace

} //linc

#endif //_LINC_OGG_IMAGE_H_
