#
# Copyright (C) 2019 Paranoid Android
#               2021 The notearOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# Handle various build version information.
#
# Guarantees that the following are defined:
#     NOTEAROS_VERSION_FLAVOR
#     NOTEAROS_VERSION_CODE
#     NOTEAROS_BUILD_VARIANT
#

ifndef NOTEAROS_VERSION_FLAVOR
  # This is the global pa version flavor that determines the focal point
  # behind our releases. This is bundled alongside the $(NOTEAROS_VERSION_CODE)
  # and only changes per major Android releases.
  NOTEAROS_VERSION_FLAVOR := Eleven
endif

ifndef NOTEAROS_VERSION_CODE
  # The version code is the upgradable portion during the cycle of
  # every major Android release. Each version code upgrade indicates
  # our own major release during each lifecycle.
  NOTEAROS_VERSION_CODE := 1
endif

# Determines the variant of the build.
# DEV: Unofficial builds given to the general population, created by
# non PA developers.
# ALPHA: Public/Private builds for testing purposes
# BETA: Public builds for testing purposes
# Public releases will not include a TAG
ifndef NOTEAROS_BUILDTYPE
  NOTEAROS_BUILD_VARIANT := DEV
else
  ifeq ($(NOTEAROS_BUILDTYPE), RELEASE)
    NOTEAROS_BUILD_VARIANT := Release
  endif
endif

# Append date to pa zip name
ifeq ($(NOTEAROS_VERSION_APPEND_TIME_OF_DAY),true)
  BUILD_DATE := $(shell date -u +%Y%m%d_%H%M%S)
else
  BUILD_DATE := $(shell date -u +%Y%m%d)
endif

NOTEAROS_VERSION := $(shell echo $(NOTEAROS_VERSION_FLAVOR) | tr A-Z a-z)-$(NOTEAROS_VERSION_CODE)-$(NOTEAROS_BUILD)-$(BUILD_DATE)-$(shell echo $(NOTEAROS_BUILD_VARIANT) | tr A-Z a-z)

# notearOS Android System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.notearos.version=$(NOTEAROS_VERSION)

# notearOS Android Platform Display Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.notearos.version.flavor=$(NOTEAROS_VERSION_FLAVOR) \
    ro.notearos.version.code=$(NOTEAROS_VERSION_CODE) \
    ro.notearos.build.variant=$(NOTEAROS_BUILD_VARIANT)
