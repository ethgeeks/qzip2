(* CamlBZ2 - OCaml bindings for libbz2 (AKA, bzip2)
 *
 * Copyright © 2000-2005 Olivier Andrieu    <oandrieu@gmail.com>
 *           © 2008      Stefano Zacchiroli <zack@upsilon.cc>
 *
 * CamlBZ2 is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License (with the
 * special exception on linking described in file COPYING) as published
 * by the Free Software Foundation; either version 2.1 of the License,
 * or (at your option) any later version.
 *)

(** {1 Bzip2 interface} *)

(** The module [Bz] provides a basic interface to the [bzip2]
    compression library. *)

(** {2 Datatypes & exceptions} *)

type in_channel
type out_channel

exception IO_error of string
  (** Exception [IO_error] is raised when there is an error reading or
      writing on a compressed channel ; the string argument is the message
      reported by the OS. *)

exception Data_error
  (** Exception [Data_error] is raised when a data integrity error is
      detected during decompression. *)

exception Unexpected_EOF
  (** Exception [Unexpected_EOF] is raised when an [in_channel]
      finishes before the logical end of stream is detected. *)

(** When any of these exception is raised, the channel is
    automatically closed (but you still have to close the Pervasives
    channel). *)

val version : string
  (** Version of the underlying [bzip2] library. *)

(** {2 File I/O} *)

(** {3 File input} *)

(** [open_in ic] opens a compressed stream reading from the
    [Pervasives] input channel [ic].

    @param small when [true] requests usage of a different method for
    decompressing that is slower but uses less memory. Defaults:
    [false]
*)
val open_in : ?small:bool -> ?unused:string -> Pervasives.in_channel ->
  in_channel

(** [read buf pos len] reads up to [len] characters and store them in
    the string buffer [buf], starting at position [pos].

    @return number of bytes actually read, (a value strictly less than
    [len] means end of stream).

    @raise End_of_file if end of stream was already reached. *)
val read : in_channel -> string -> int -> int -> int

(** If there's some data after the compressed stream that you want to
    read from the same [Pervasives] [in_channel], use
    [read_get_unused]. *)
val read_get_unused : in_channel -> string

val close_in : in_channel -> unit

(** {3 File output} *)

(** [open_out oc] creates an [out_channel] writing to the [Pervasives]
    output channel [oc]. Once the write operations are finished and
    the compressed channel is closed, it is possible to continue
    writing on the [Pervasives] channel. However, reading back
    requires special care (cf. above).

    @param block block size to use for compresion. It is a value
    between 1 and 9 inclusive. 9 is the default and provides best
    compression but takes most memory. *)
val open_out : ?block:int -> Pervasives.out_channel -> out_channel

(** [write oc buf pos len] writes [len] characters, coming from [buf]
    and starting at position [pos], to [oc] *)
val write : out_channel -> string -> int -> int -> unit

val close_out : out_channel -> unit


(** {2 In-memory compression} *)

(** These functions compress to/decompress from string buffers. *)

(** [compress buf pos len] compress a data chunk coming from [buf],
    [len] character long, and starting at [pos].

    @return compressed data chunk as string *)
val compress : ?block:int -> string -> int -> int -> string

(** [uncompress buf pos len] uncompress a data chunk comfing from
    [buf], [len] character long, and starting at [pos].

    @param small see [Bz2.open_in] above
    @return uncompressed data chunk as string *)
val uncompress : ?small:bool -> string -> int -> int -> string
