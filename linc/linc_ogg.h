#pragma once

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

#include "ogg/ogg.h"
#include "vorbis/vorbisfile.h"

namespace linc {

    namespace ogg {

        typedef ::cpp::Pointer<OggVorbis_File> OggFile;
        typedef Array<unsigned char> OggBytesData;

            extern OggFile newOggVorbisFile();
            extern Dynamic ov_comment(OggFile vf, int link);
            extern int ov_read(OggFile vf, OggBytesData buffer, int byteOffset, int length, int bigendianp, int word, int sgned);

        //internal

            typedef ::cpp::Function < int(int,int,int,OggBytesData) > InternalReadFN;
            typedef ::cpp::Function < int(int,int,int) > InternalSeekFN;
            typedef ::cpp::Function < int(int) > InternalCloseFN;
            typedef ::cpp::Function < int(int) > InternalTellFN;

            extern int internal_open_callbacks(int cb_id, OggFile vf, OggBytesData initial, int ibytes);
            extern void init_callbacks(
                InternalReadFN _read_fn,
                InternalSeekFN _seek_fn,
                InternalCloseFN _close_fn,
                InternalTellFN _tell_fn
            );

            extern size_t ogg_read_func(void* ptr, size_t size, size_t nmemb, void* userdata);
            extern int ogg_seek_func(void* userdata, ogg_int64_t offset, int whence);
            extern int ogg_close_func(void* userdata);
            extern long ogg_tell_func(void* userdata);

    } //ogg namespace

} //linc
