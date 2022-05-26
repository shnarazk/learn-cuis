'From Cuis 6.0 [latest update: #5191] on 26 May 2022 at 11:56:37 pm'!
'Description '!
!provides: 'AdventOfCode' 1 3!
SystemOrganization addCategory: 'AdventOfCode-Test'!
SystemOrganization addCategory: 'AdventOfCode'!


!classDefinition: #Day11StateCodeTest category: 'AdventOfCode-Test'!
TestCase subclass: #Day11StateCodeTest
	instanceVariableNames: 'aStart aGoal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'AdventOfCode-Test'!
!classDefinition: 'Day11StateCodeTest class' category: 'AdventOfCode-Test'!
Day11StateCodeTest class
	instanceVariableNames: ''!

!classDefinition: #Day11StateCode category: 'AdventOfCode'!
Object subclass: #Day11StateCode
	instanceVariableNames: 'code cost estimatedCost'
	classVariableNames: 'Goal Kinds Width'
	poolDictionaries: ''
	category: 'AdventOfCode'!
!classDefinition: 'Day11StateCode class' category: 'AdventOfCode'!
Day11StateCode class
	instanceVariableNames: ''!


!Day11StateCode commentStamp: '<historical>' prior: 0!
Compressed state description!

!Day11StateCodeTest methodsFor: 'testing' stamp: 'shnarazk 5/26/2022 23:55:46'!
setUp
	Day11StateCode setKinds: 2.
	aStart _ Day11StateCode new.
	aGoal _ Day11StateCode new initializeAs: 63.! !

!Day11StateCodeTest methodsFor: 'testing' stamp: 'shnarazk 5/26/2022 22:53:05'!
testAdjacentFloors
self assert: aStart adjacentFloors equals: { 1 }.
self assert: aGoal adjacentFloors equals: { 2 }.! !

!Day11StateCodeTest methodsFor: 'testing' stamp: 'shnarazk 5/26/2022 23:52:25'!
testIsGoal
	"a test"
	self
		
			assert: aStart isGoal
			equals: false.
		self 
			assert: aGoal isGoal
			equals: true.! !

!Day11StateCodeTest methodsFor: 'testing' stamp: 'shnarazk 5/25/2022 20:11:43'!
testIsStart
	"a test"
	self
		
			assert: aStart isStart
			equals: true.
	self
		
			assert: aGoal isStart
			equals: false.! !

!Day11StateCodeTest class methodsFor: 'as yet unclassified' stamp: 'shnarazk 5/26/2022 22:56:08'!
aStart
	Day11StateCode setKinds: 2.	
	^Day11StateCode new.! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 22:01:07'!
adjacentFloors
	| floor |
	floor _ self floor.
floor = 0 ifTrue: [ ^ {1 } ].
	floor = 3 ifTrue: [ ^ {2 } ].
	^ {floor - 1 , floor + 1}.! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 23:46:17'!
floor
^self floorOfObject: 1! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 23:47:30'!
floor: aFloor
	^ self
		floorOfObject: 1
		to: aFloor.! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 23:44:06'!
floorOfObject: anObject
	| mask result |
	mask _ self class kinds * 2 - anObject + 1.
	mask _ 1 << mask.
	result _ (code bitAnd: mask) > 0
		ifTrue: [ 2 ]
		ifFalse: [ 0 ].
	mask _ mask >> 1.
	(code bitAnd: mask) > 0
		ifTrue: [ ^ result + 1 ]
		ifFalse: [ ^ result ].! !

!Day11StateCode methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 23:43:53'!
floorOfObject: anObject to: floor
	| mask |
	mask _ self class kinds - anObject * 2 + 1.
	mask _ 1 << mask.
	code _ code bitClear: mask.
	floor > 1 ifTrue: [ code _ code bitOr: mask ].
	mask _ mask >> 1.
	code _ code bitClear: mask.
	floor odd ifTrue: [ code _ code bitOr: mask ].! !

!Day11StateCode methodsFor: 'initialization' stamp: 'shnarazk 5/25/2022 20:07:50'!
initialize
"every instance is initialized as being a start."
	super initialize.
	code _ 0.! !

!Day11StateCode methodsFor: 'initialization' stamp: 'shnarazk 5/25/2022 20:07:00'!
initializeAs: anIndex
	self initialize.
	code _ anIndex.! !

!Day11StateCode methodsFor: 'associating' stamp: 'shnarazk 5/26/2022 23:08:06'!
allObjectPairsOn: floor do: aBlock
	"all but elevator"
	| objects |
	objects _ self class kinds * 2.
	2
		to: objects
		do: [ :i |
			(self floorOf: i) = floor ifTrue: [
				i
					to: objects
					do: [ :j |
						(self floorOf: j) = floor ifTrue: [
							aBlock
								value: i
								value: j ]]]].! !

!Day11StateCode methodsFor: 'associating' stamp: 'shnarazk 5/26/2022 23:03:05'!
allObjectsOn: floor do: aBlock
	"all but elevator"
	2
		to: self class kinds * 2
		do: [ :i |
			Transcript show: 'fould'.
			i = floor ifTrue: [ aBlock value: i ]].! !

!Day11StateCode methodsFor: 'associating' stamp: 'shnarazk 5/26/2022 23:00:41'!
neighborStates
	"the main logic"
	| floor result |
	result _ Set new.
	floor _ self floorOf: 1.
	Transcript show: floor.
	self
		allObjectPairsOn: floor
		do: [ :i :j |
			Transcript show: i asString , ' - ' , j asString.
			self adjacentFloors do: [ :f | | newState |
				newState _ self
					moveTo: f
					with: i
					and: j.
				newState isSafe ifTrue: [ result add: newState ]]].
	^ result.! !

!Day11StateCode methodsFor: 'evaluating' stamp: 'shnarazk 5/25/2022 20:53:05'!
isGoal
	^ code = self class goal ! !

!Day11StateCode methodsFor: 'evaluating' stamp: 'shnarazk 5/26/2022 23:42:38'!
isSafe
	1 to: self kinds do: [ :k | 
		]! !

!Day11StateCode methodsFor: 'evaluating' stamp: 'shnarazk 5/25/2022 20:08:28'!
isStart
^ code = 0! !

!Day11StateCode methodsFor: 'copying' stamp: 'shnarazk 5/26/2022 23:40:08'!
moveTo: floor with: anObjest and: anotherObject
	| state  |
	state _ self class new initializeAs: code.
	state floor: floor;
	floorOf: anObjest to: floor;
	floorOf: anotherObject to: floor .
	^ state.! !

!Day11StateCode class methodsFor: 'accessing' stamp: 'shnarazk 5/25/2022 20:51:58'!
goal
^Goal ! !

!Day11StateCode class methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 22:03:41'!
kinds
^Kinds ! !

!Day11StateCode class methodsFor: 'accessing' stamp: 'shnarazk 5/26/2022 18:02:44'!
setKinds: k
Kinds _ k.
	Width _ k + 1 * 2.
	Goal _ 2 ^ Width - 1.! !

!Day11StateCode class methodsFor: 'accessing' stamp: 'shnarazk 5/25/2022 20:57:43'!
setWidth: aWidth
	Width _ aWidth.
	Goal _ 2 ^ aWidth - 1.! !

!Day11StateCode class methodsFor: 'accessing' stamp: 'shnarazk 5/25/2022 20:49:33'!
width
^ Width! !

!Day11StateCode class methodsFor: 'instance creation' stamp: 'shnarazk 5/26/2022 23:36:03'!
newWith: aCode
	| instance |
	instance _ self new.
	instance initializeAs: aCode.
	^ instance.! !
