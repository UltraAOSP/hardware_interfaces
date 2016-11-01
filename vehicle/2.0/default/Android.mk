# Copyright (C) 2016 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

module_prefix = android.hardware.vehicle@2.0

###############################################################################
# Vehicle reference implementation lib
###############################################################################
include $(CLEAR_VARS)
LOCAL_MODULE := $(module_prefix)-manager-lib
LOCAL_SRC_FILES := \
    vehicle_hal_manager/SubscriptionManager.cpp \
    vehicle_hal_manager/VehicleHalManager.cpp \
    vehicle_hal_manager/VehicleCallback.cpp \

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libbinder \
    libhidl \
    libhwbinder \
    libutils \
    $(module_prefix) \

include $(BUILD_STATIC_LIBRARY)

###############################################################################
# Vehicle default VehicleHAL implementation
###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE:= $(module_prefix)-default-impl-lib
LOCAL_SRC_FILES:= \
    impl/DefaultVehicleHal.cpp \

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libbinder \
    libhidl \
    libhwbinder \
    libutils \
    $(module_prefix) \

include $(BUILD_STATIC_LIBRARY)


###############################################################################
# Vehicle reference implementation unit tests
###############################################################################
include $(CLEAR_VARS)

LOCAL_MODULE:= $(module_prefix)-manager-unit-tests

LOCAL_WHOLE_STATIC_LIBRARIES := $(module_prefix)-manager-lib

LOCAL_SRC_FILES:= \
    tests/VehicleObjectPool_test.cpp \
    tests/VehiclePropConfigIndex_test.cpp \
    tests/SubscriptionManager_test.cpp \
    tests/VehicleHalManager_test.cpp \

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libbinder \
    libhidl \
    libhwbinder \
    libutils \
    $(module_prefix) \

LOCAL_CFLAGS += -Wall -Wextra
LOCAL_MODULE_TAGS := tests

include $(BUILD_NATIVE_TEST)


###############################################################################
# Vehicle HAL service
###############################################################################
include $(CLEAR_VARS)
LOCAL_MODULE := $(module_prefix)-service
LOCAL_MODULE_RELATIVE_PATH := hw
# TODO(pavelm): add LOCAL_INIT_RC

LOCAL_SRC_FILES := \
    VehicleService.cpp

LOCAL_WHOLE_STATIC_LIBRARIES := \
    $(module_prefix)-manager-lib \
    $(module_prefix)-default-impl-lib \

LOCAL_SHARED_LIBRARIES := \
    liblog \
    libbinder \
    libhidl \
    libhwbinder \
    libutils \
    android.hardware.vehicle@2.0

include $(BUILD_EXECUTABLE)
