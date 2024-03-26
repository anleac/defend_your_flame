'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"index.html": "ee44501d825d34c129d13811dd55a105",
"/": "ee44501d825d34c129d13811dd55a105",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"assets/FontManifest.json": "9eae876a6b581f86d7f7db4ffac66782",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/AssetManifest.bin.json": "257d3aa343f7d8f2cb960e4f0cc141bd",
"assets/assets/images/mobs/mage/walk.png": "bdf1d82df0be51324af2c71eabe0d4b5",
"assets/assets/images/mobs/mage/dying.png": "8cdd9e50351fba923d01763a4029c96f",
"assets/assets/images/mobs/mage/idle.png": "8cdd9e50351fba923d01763a4029c96f",
"assets/assets/images/mobs/mage/attack.png": "3505fe1f2168667fcac623325c9951e9",
"assets/assets/images/mobs/skeleton/walk.png": "a5eeafde55a5ed2042277f4e71b6e744",
"assets/assets/images/mobs/skeleton/dying.png": "11f0c1c66974691e79e8f4c17db17d35",
"assets/assets/images/mobs/skeleton/attack.png": "48603f3134dc7ef716a8ea783dcf6947",
"assets/assets/images/mobs/skeleton/drag.png": "e0e6a0425bf07a6b93c34a58d0f072ef",
"assets/assets/images/mobs/slime/walk.png": "2b26988a8c2954e700cbb44caf9fcc11",
"assets/assets/images/mobs/slime/dying.png": "d0c07f96afd58f996076aa4aa1fa3f87",
"assets/assets/images/mobs/slime/attack.png": "6330ae1fb41457edf9714a22e5bcbc82",
"assets/assets/images/mobs/slime/drag.png": "d11af840bf79315b38722537dd49d334",
"assets/assets/images/flames/blue/loops/2.png": "1d39a0a7193e37e19930f88b976e7342",
"assets/assets/images/flames/purple/loops/1.png": "ea11af1057c368ffec141be626086bc3",
"assets/assets/images/castle.png": "6ad9ff077b1be8525e392a6e54b05078",
"assets/assets/images/environment/old_grass.png": "c4c872fa44d21dfa60ec66d638e3671e",
"assets/assets/images/environment/grass.png": "2b7e4570f9f00638271116aba0e1a74c",
"assets/assets/images/environment/background.png": "a61b2da72dd587b0b062634bc070123d",
"assets/assets/images/hud/heart.png": "56ce696d826ed8793ff4364f0a351123",
"assets/assets/images/hud/gold.png": "5e96322e72b93ebde2f5f504a8d87d65",
"assets/assets/fonts/Metropolis-Regular.otf": "f7b5e589f88206b4bd5cb1408c5362e6",
"assets/assets/fonts/Metropolis-Bold.otf": "dea4998b081c6c1133a3b5b08ff2218c",
"assets/assets/fonts/Metropolis-Light.otf": "c82170e08b76657553ab939bd28e8515",
"assets/assets/fonts/prstart.ttf": "65cb344c64e3d29ae35396789de64c2e",
"assets/assets/fonts/Metropolis-RegularItalic.otf": "763b44257f3ad942e107551bff15b544",
"assets/assets/fonts/ThaleahFat.ttf": "684a353191db0b6ef85bd86e34b671a0",
"assets/AssetManifest.bin": "1e03332abb5cf879317265eb1347a832",
"assets/NOTICES": "b38a64260cd36f8ca9b9b95b8c2b13f7",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/AssetManifest.json": "d837af0cc298631ebc9e75799e6a8dab",
"version.json": "2a52fe2c2fddbcbcbd848cb8f632a361",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"manifest.json": "e0622def0ed298c68ff0c1abf01ddb08",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"main.dart.js": "2e3a10076ef94671c6c1dfe24983d844"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
