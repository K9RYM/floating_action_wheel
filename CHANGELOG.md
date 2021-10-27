## v[0.9.0] - Beta for open testing

Initial release: v0.9.0 BETA
features/changes from previous version:
1- the FAB and the ImmersiveWheel widgets now using CompositeTransformTarget/Follower widgets to attach them to each other, previous version
   was using an Overlay widget and was incompatible with the Scaffold's FAB slot
2- added parameter to separate each button
3- added text/icon parameters to wheel buttons as well as giving each its size explicitly if they dont fit well


known bugs/flaws for this version to fix in next release:
1- FAB icon quality is slightly low 
2- often need to give WheelButton's text/icon sizes to fit the button canvas if both are used
