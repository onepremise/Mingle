/*
 * ====================================================================
 *    Licensed to the Apache Software Foundation (ASF) under one
 *    or more contributor license agreements.  See the NOTICE file
 *    distributed with this work for additional information
 *    regarding copyright ownership.  The ASF licenses this file
 *    to you under the Apache License, Version 2.0 (the
 *    "License"); you may not use this file except in compliance
 *    with the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing,
 *    software distributed under the License is distributed on an
 *    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 *    KIND, either express or implied.  See the License for the
 *    specific language governing permissions and limitations
 *    under the License.
 * ====================================================================
 *
 * svn_diff.i: SWIG interface file for svn_diff.h
 */

#if defined(SWIGPYTHON)
%module(package="libsvn") diff
#elif defined(SWIGPERL)
%module "SVN::_Diff"
#elif defined(SWIGRUBY)
%module "svn::ext::diff"
#endif

%include svn_global.swg
%import core.i

/* -----------------------------------------------------------------------
   %apply-ing of typemaps defined elsewhere
*/

%apply const char *MAY_BE_NULL {
    const char *original_header,
    const char *modified_header,
    const char *header_encoding,
    const char *relative_to_dir
};

#ifdef SWIGPYTHON
%apply svn_stream_t *WRAPPED_STREAM { svn_stream_t * };

/* The WRAPPED_STREAM typemap can't cope with struct members, and there
   isn't really a reason to change these. */
%immutable svn_diff_hunk_t::diff_text;
%immutable svn_diff_hunk_t::original_text;
%immutable svn_diff_hunk_t::modified_text;

/* Ditto. */
%immutable svn_patch_t::patch_file;
#endif

/* ----------------------------------------------------------------------- */

#ifdef SWIGPERL
%{
#include "svn_private_config.h"

#include <apr.h>
#include <apr_general.h>

#define SVN_SWIGIMPORT(t) __declspec( dllimport ) t

SVN_SWIGIMPORT(apr_pool_t *) svn_swig_pl_get_current_pool (void);
SVN_SWIGIMPORT(void) svn_swig_pl_set_current_pool (apr_pool_t *pool);
%}

%init %{
#if defined(SVN_AVOID_CIRCULAR_LINKAGE_AT_ALL_COSTS_HACK)
  //apr_status_t result;
  //result = (apr_status_t)apr_initialize();
  //if (result>0) {
  //    XSRETURN(result);
  //}
  svn_swig_pl_bind_current_pool_fns (&svn_swig_pl_get_current_pool,
                                     &svn_swig_pl_set_current_pool);
#endif
%}
#endif


/* ----------------------------------------------------------------------- */

%include svn_diff_h.swg
