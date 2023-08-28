import { NativeModules, Platform } from 'react-native';
const LINKING_ERROR = `The package '@sleiv/react-native-common-utils' doesn't seem to be linked. Make sure: \n\n` + Platform.select({
  ios: "- You have run 'pod install'\n",
  default: ''
}) + '- You rebuilt the app after installing the package\n' + '- You are not using Expo Go\n';
function createModuleProxy(moduleName) {
  if (NativeModules[moduleName]) {
    return NativeModules[moduleName];
  } else {
    return new Proxy({}, {
      get() {
        throw new Error(LINKING_ERROR);
      }
    });
  }
}
export const AppNavigator = createModuleProxy('AppNavigator');
//# sourceMappingURL=index.js.map