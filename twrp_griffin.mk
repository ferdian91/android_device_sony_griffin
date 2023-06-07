#
# Copyright 2017 The Android Open Source Project
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
# Only the below variable(s) need to be changed!
#
# Define hardware platform
PRODUCT_PLATFORM := msmnile
PRODUCT_RELEASE_NAME := griffin
DEVICE_PATH := device/sony/griffin

$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/embedded.mk)
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)
$(call inherit-product-if-exists, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from griffin_docomo device
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# Inherit some common twrp stuff.
$(call inherit-product-if-exists, vendor/twrp/config/gsm.mk)
$(call inherit-product-if-exists, vendor/twrp/config/common.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := griffin
PRODUCT_NAME := twrp_griffin
PRODUCT_BRAND := Sony
PRODUCT_MODEL := Xperia 1
PRODUCT_MANUFACTURER := Sony
