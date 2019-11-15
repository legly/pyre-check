(* Copyright (c) 2016-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree. *)
open Ast
open SharedMemoryKeys

module HierarchyReadOnly : sig
  include Environment.ReadOnly

  val get_edges
    :  t ->
    ?dependency:dependency ->
    IndexTracker.t ->
    ClassHierarchy.Target.t list option

  val get_undecorated_function
    :  t ->
    ?dependency:dependency ->
    Reference.t ->
    Type.t Type.Callable.overload option

  val alias_environment : t -> AliasEnvironment.ReadOnly.t

  val check_integrity : t -> unit
end

include
  Environment.S
    with module ReadOnly = HierarchyReadOnly
     and module PreviousEnvironment = AliasEnvironment
