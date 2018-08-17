package android

// Global config used by custom soong additions
var CustomConfig = struct {
	// List of packages that are permitted
	// for java source overlays.
	JavaSourceOverlayModuleWhitelist []string
}{
	// JavaSourceOverlayModuleWhitelist
	[]string{
		"org.pixelexperience.keydisabler",
	},
}
