'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"icons/Icon-maskable-192.png": "0b4393dd6b2d3da4b9a2075c2105ed6c",
"icons/Icon-maskable-512.png": "92c40e3db29f3ef7651fbfee4aa47195",
"icons/Icon-512.png": "92c40e3db29f3ef7651fbfee4aa47195",
"icons/Icon-192.png": "0b4393dd6b2d3da4b9a2075c2105ed6c",
"manifest.json": "aa486cb68af3d09682580b1372796b44",
"favicon.png": "3b172a66e49b95015a8061c73cd01cc9",
"flutter_bootstrap.js": "ff934a7b465297cedec9e29f3343f930",
"version.json": "067b1286bd978f655ff3e1e1650313a2",
"index.html": "b259eaa723c0c07b4f2b9b52d73a6fbf",
"/": "b259eaa723c0c07b4f2b9b52d73a6fbf",
"main.dart.js": "a111bae9147e5879d1969f3b19bf21b2",
"assets/AssetManifest.json": "f2d528264d1aa8d45446cc4621a4b135",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "4be17e2c7f996cd88face8854d94d9c6",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/assets/images/flames/purple/loops/1.png": "ea11af1057c368ffec141be626086bc3",
"assets/assets/images/flames/blue/loops/2.png": "1d39a0a7193e37e19930f88b976e7342",
"assets/assets/images/mobs/rat/attack.png": "b01a1da69bb869c7c3c8ff3a2581c40c",
"assets/assets/images/mobs/rat/walk.png": "eb0e8363d8ed15235cad39a03f969590",
"assets/assets/images/mobs/rat/drag.png": "d2a3c164fd47bfee1165e80ed2a1c4a2",
"assets/assets/images/mobs/rat/dying.png": "3b7e77689e40bf0f3fe558ee3cb33456",
"assets/assets/images/mobs/ice_wolf/attack.png": "935098b88e77170aeedb18717b738f8a",
"assets/assets/images/mobs/ice_wolf/walk.png": "3509e2ce68e63b8b10f2c42eef33a6fc",
"assets/assets/images/mobs/ice_wolf/drag.png": "13106f6002eb42e19bc9b4f77b034f05",
"assets/assets/images/mobs/ice_wolf/dying.png": "339102f3c4f5f829a3c596684139c4bc",
"assets/assets/images/mobs/strong_skeleton/attack.png": "cbdefae61bb5612e7025a965ce843fe4",
"assets/assets/images/mobs/strong_skeleton/walk.png": "d5cc8aa041f6bc29ad50ad015814490d",
"assets/assets/images/mobs/strong_skeleton/drag.png": "651110f0c5935a68b7b8e3ae78ada741",
"assets/assets/images/mobs/strong_skeleton/dying.png": "836219f9ac457c5aeb64c8f9585307c4",
"assets/assets/images/mobs/strong_skeleton/damaged.png": "a2171499a8f033779fc35e406173766f",
"assets/assets/images/mobs/bosses/fire_beast/attack.png": "4c22956c642e3edfb62759bf752669f4",
"assets/assets/images/mobs/bosses/fire_beast/walk.png": "40f1ee7b61daba94f1e1702f768f4b9e",
"assets/assets/images/mobs/bosses/fire_beast/idle.png": "8da3403ff7caaa3430068b969c5de789",
"assets/assets/images/mobs/bosses/fire_beast/dying.png": "81a05c3b76acb3041348ec427b77ef86",
"assets/assets/images/mobs/bosses/fire_beast/hurt.png": "7b1f15fce6c799cc68738fffde9932a6",
"assets/assets/images/mobs/bosses/death_reaper/attack.png": "bc3e3160ce9bfb1e40cc3c78d050fa53",
"assets/assets/images/mobs/bosses/death_reaper/walk.png": "ea468c2be2dfc6dba2dacb100b2beb08",
"assets/assets/images/mobs/bosses/death_reaper/cast.png": "0d00923254f24d30742f63de20f27b8c",
"assets/assets/images/mobs/bosses/death_reaper/idle.png": "ed308ee68d3e1e1c3706ffcd0c5a1f64",
"assets/assets/images/mobs/bosses/death_reaper/dying.png": "75a97da786aeeab8dd07e142eab5e3a1",
"assets/assets/images/mobs/bosses/death_reaper/hurt.png": "c88b3afb0bbb14021c3dec241ea46b6e",
"assets/assets/images/mobs/slime/attack.png": "6330ae1fb41457edf9714a22e5bcbc82",
"assets/assets/images/mobs/slime/walk.png": "2b26988a8c2954e700cbb44caf9fcc11",
"assets/assets/images/mobs/slime/drag.png": "d11af840bf79315b38722537dd49d334",
"assets/assets/images/mobs/slime/dying.png": "d0c07f96afd58f996076aa4aa1fa3f87",
"assets/assets/images/mobs/skeleton/attack.png": "48603f3134dc7ef716a8ea783dcf6947",
"assets/assets/images/mobs/skeleton/walk.png": "a5eeafde55a5ed2042277f4e71b6e744",
"assets/assets/images/mobs/skeleton/drag.png": "e0e6a0425bf07a6b93c34a58d0f072ef",
"assets/assets/images/mobs/skeleton/dying.png": "11f0c1c66974691e79e8f4c17db17d35",
"assets/assets/images/mobs/rock_golem/attack.png": "6ab0c190c31509f7c1cb6dd748c0dea7",
"assets/assets/images/mobs/rock_golem/walk.png": "4044402fb414682b5ca402c87ce418fb",
"assets/assets/images/mobs/rock_golem/drag.png": "d4f415916c3b2d5ff1348794912d1eb9",
"assets/assets/images/mobs/rock_golem/idle.png": "8591038c1490528c4ae427b5d3789cb7",
"assets/assets/images/mobs/rock_golem/dying.png": "1b87b7466483e88ed6409ed42288335e",
"assets/assets/images/mobs/rock_golem/hurt.png": "f8b75c69b2ff1e4f58e0187ff7a7ac74",
"assets/assets/images/mobs/mage/attack.png": "3505fe1f2168667fcac623325c9951e9",
"assets/assets/images/mobs/mage/walk.png": "bdf1d82df0be51324af2c71eabe0d4b5",
"assets/assets/images/mobs/mage/idle.png": "8cdd9e50351fba923d01763a4029c96f",
"assets/assets/images/mobs/mage/dying.png": "8e8ed69de35ab0fe471988194dd00132",
"assets/assets/images/masonry/wood-wall.png": "1eafc38986dba28bd368fb69295ae9c6",
"assets/assets/images/masonry/stone-totem.png": "c703450cea0901fb038f25f42edc4239",
"assets/assets/images/masonry/barricade-wall.png": "174da212cfa8a14ee892241577e738fe",
"assets/assets/images/masonry/stone-wall.png": "485aaa57c3c17615e5e587bc03f0ee3b",
"assets/assets/images/hud/flame.png": "3046c4e798428b210dbfbb2ab2a5048f",
"assets/assets/images/hud/gold.png": "35249ebe2edbe0db1b2af8433fbea21d",
"assets/assets/images/hud/heart.png": "2626cd4408b8edc56ee132f62f1fec77",
"assets/assets/images/environment/background.png": "a61b2da72dd587b0b062634bc070123d",
"assets/assets/images/environment/grass.png": "60342dbba870c98d98104790a26e8e3e",
"assets/assets/images/environment/rocks/rock2.png": "f82f8a25004713babc0ef801c2930397",
"assets/assets/images/environment/rocks/rock1.png": "026bf2573f1e7c00ae8c5ce0899f20d7",
"assets/assets/images/environment/rocks/rock3.png": "0cded0d32d8e252cf26fccaf5d5f5b16",
"assets/assets/images/environment/rocks/rock4.png": "57c639b5abfe2515591308c271252b0f",
"assets/assets/images/environment/rocks/rock5.png": "b6e2b2dbbab692ef2305095b960f71dd",
"assets/assets/images/environment/rocks/rock6.png": "96c58cc43429c343c7feee1a922eebdb",
"assets/assets/images/environment/old_grass.png": "d77638469d794d0363b713978747c3c6",
"assets/assets/images/npcs/alchemist/work2.png": "4e675c48d15b48f133c7c0eecb7bdec5",
"assets/assets/images/npcs/alchemist/work.png": "8c5faee1b21b93b678c305978fa2ad01",
"assets/assets/images/npcs/blacksmith/work.png": "59a96bd0c2e83042b7c49fda60d575d7",
"assets/assets/images/icon.png": "e48af3339afb1cabc6bd91f7dcbdd398",
"assets/assets/fonts/prstart.ttf": "65cb344c64e3d29ae35396789de64c2e",
"assets/assets/fonts/Monocraft.ttf": "f574c2b0e8ded14c669764ed4efab719",
"assets/NOTICES": "41d6faf158dddc34baa9b5f9a18b32d4",
"assets/AssetManifest.bin": "4f6e0a7ecea10948e7958ecc2787d763",
"assets/FontManifest.json": "831d868b0b7952aaa8cd949a1c36cb46",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
