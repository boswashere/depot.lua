-- Set all textures to lower quality for FPS boost
game:GetService("Workspace").Terrain.Texture = "rbxasset://textures/TerrainGrass_Dark.dds"
game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").TextureQuality = "8" -- Lower texture quality
game:GetService("Lighting").ShadowSoftness = 0
game:GetService("Lighting").Brightness = 0.5 -- Lower brightness
game:GetService("Lighting").ClockTime = 12
game:GetService("Lighting").FogEnd = 50000 -- Decrease fog distance
game:GetService("Lighting").FogStart = 0
game:GetService("Lighting").FogColor = Color3.fromRGB(128, 128, 128)
game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(64, 64, 64) -- Lower ambient lighting
game:GetService("Lighting").Ambient = Color3.fromRGB(64, 64, 64) -- Lower ambient lighting
