Class {
	#name : 'LeIdeaSnippet',
	#superclass : 'LeTextSnippet',
	#instVars : [
		'idea'
	],
	#category : 'Ideas'
}

{ #category : 'instance creation' }
LeIdeaSnippet class >> forIdea: anIdea [
	^ self new
		idea: anIdea;
		yourself
]

{ #category : 'accessing' }
LeIdeaSnippet >> asElement [
	^ self idea asElement
]

{ #category : 'accessing' }
LeIdeaSnippet >> idea [
	^ idea
]

{ #category : 'accessing' }
LeIdeaSnippet >> idea: anIdea [
	idea := anIdea
]

{ #category : 'accessing' }
LeIdeaSnippet >> spawnLinkTarget: aNode from: aButton [
	Halt once.
	^ super spawnLinkTarget: aNode from: aButton
]
