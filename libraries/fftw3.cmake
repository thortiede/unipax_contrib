# -----------------------------------------------------------------------------
#   BALL - Biochemical ALgorithms Library
#   A C++ framework for molecular modeling and structural bioinformatics.
# -----------------------------------------------------------------------------
#
# Copyright (C) 1996-2012, the BALL Team:
#  - Andreas Hildebrandt
#  - Oliver Kohlbacher
#  - Hans-Peter Lenhof
#  - Eberhard Karls University, Tuebingen
#  - Saarland University, Saarbrücken
#  - others
#
#  This library is free software; you can redistribute it and/or
#  modify it under the terms of the GNU Lesser General Public
#  License as published by the Free Software Foundation; either
#  version 2.1 of the License, or (at your option) any later version.
#
#  This library is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#  Lesser General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public
#  License along with this library (BALL/source/LICENSE); if not, write
#  to the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
#  Boston, MA  02111-1307  USA
#
# -----------------------------------------------------------------------------
# $Maintainer: Philipp Thiel $
# $Authors: Philipp Thiel $
# -----------------------------------------------------------------------------

MSG_CONFIGURE_PACKAGE_BEGIN("${PACKAGE_NAME}")

IF(OS_WINDOWS)
	SET(OPENBABEL_GIT_BRANCH "patched_windows")
ELSE()
	SET(OPENBABEL_GIT_BRANCH "patched")
ENDIF()

ExternalProject_Add(${PACKAGE_NAME}

	PREFIX ${PROJECT_BINARY_DIR}
	DOWNLOAD_COMMAND git clone "${GITHUB_BASE_URL}/${PACKAGE_NAME}.git" --depth 1 --branch ${OPENBABEL_GIT_BRANCH}

	BUILD_IN_SOURCE ${CUSTOM_BUILD_IN_SOURCE}

	LOG_DOWNLOAD ${CUSTOM_LOG_DOWNLOAD}
	LOG_UPDATE ${CUSTOM_LOG_UPDATE}
	LOG_CONFIGURE ${CUSTOM_LOG_CONFIGURE}
	LOG_BUILD ${CUSTOM_LOG_BUILD}
	LOG_INSTALL ${CUSTOM_LOG_INSTALL}

	CONFIGURE_COMMAND "${CONTRIB_BINARY_SRC}/${PACKAGE_NAME}/bootstrap.sh" --enable-shared --with-pic -q --prefix=${CONTRIB_INSTALL_BASE}
	BUILD_COMMAND make -j "${N_MAKE_THREADS}"
	INSTALL_COMMAND make install
)

MSG_CONFIGURE_PACKAGE_END("${PACKAGE_NAME}")