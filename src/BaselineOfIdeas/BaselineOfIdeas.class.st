Class {
	#name : #BaselineOfIdeas,
	#superclass : #BaselineOf,
	#category : #BaselineOfIdeas
}

{ #category : #testing }
BaselineOfIdeas class >> isDynabook [
	^ true
]

{ #category : #baseline }
BaselineOfIdeas >> baseline: spec [
	<baseline>
	
	spec for: #'common' do: [
		spec 
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: 'Ideas' with: [
			spec requires: #('Magritte' 'Mocketry' 'PharoEnhancements' 'SimplePersistence') ] ].
]

{ #category : #accessing }
BaselineOfIdeas >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #(notGToolkit) ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #accessing }
BaselineOfIdeas >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
