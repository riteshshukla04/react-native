/**
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @flow strict-local
 * @format
 */

'use strict';

/**
 * Check for compatibility between the JS and native code.
 * You can use this module directly, or just require InitializeCore.
 */
const ReactNativeVersionCheck = require('./ReactNativeVersionCheck');

ReactNativeVersionCheck.checkVersions();
