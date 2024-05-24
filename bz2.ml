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

type in_channel
type out_channel

exception IO_error of string
exception Data_error
exception Unexpected_EOF

let _ = begin
  Callback.register_exception "mlbz_io_exn" (IO_error "") ;
  Callback.register_exception "mlbz_data_exn" Data_error ;
  Callback.register_exception "mlbz_eof_exn" Unexpected_EOF
end

external library_version : unit -> string
  = "mlbz_version"

let version = library_version ()

external open_in : ?small:bool -> ?unused:string -> Pervasives.in_channel ->
  in_channel 
  = "mlbz_readopen"

external read : in_channel -> string -> int -> int -> int
  = "mlbz_read"

external read_get_unused : in_channel -> string
  = "mlbz_readgetunused"

external close_in : in_channel -> unit
  = "mlbz_readclose"

external open_out : ?block:int -> Pervasives.out_channel -> out_channel
  = "mlbz_writeopen"

external write : out_channel -> string -> int -> int -> unit
  = "mlbz_write"

external close_out : out_channel -> unit
  = "mlbz_writeclose"


external compress : ?block:int -> string -> int -> int -> string
  = "mlbz_compress"

external uncompress : ?small:bool -> string -> int -> int -> string
  = "mlbz_uncompress"
