Class {
	#name : 'IdLeDatabase',
	#superclass : 'LeDatabase',
	#instVars : [
		'mind'
	],
	#category : 'Ideas'
}

{ #category : 'accessing' }
IdLeDatabase >> mind [

	^ mind
]

{ #category : 'accessing' }
IdLeDatabase >> mind: anObject [

	mind := anObject
]

{ #category : 'initialization' }
IdLeDatabase >> pageBuilder [
	^ IdLeDatabasePageBuilder new database: self
]

{ #category : 'initialization' }
IdLeDatabase >> setPageUpdate: aLePage [
	super setPageUpdate: aLePage.
	"self mind newConcept markdownString: "
]
