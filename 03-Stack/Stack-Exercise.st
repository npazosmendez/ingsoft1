!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'initialization' stamp: 'DR 4/25/2018 00:54:43'!
initialize
	top := StackBase new! !


!OOStack methodsFor: 'modification' stamp: 'DR 4/25/2018 00:06:08'!
pop
	| previousTop |
	
	previousTop := top.
	top := top objectBelow.
	^previousTop object
	! !

!OOStack methodsFor: 'modification' stamp: 'DR 4/25/2018 01:10:16'!
push: anObjectToPush
	| aStackedObject |
	
	aStackedObject := StackedObject with: anObjectToPush stackedOver: top.
	top := aStackedObject.
! !


!OOStack methodsFor: 'information' stamp: 'np 4/23/2018 21:35:34'!
isEmpty
	^top isBase! !

!OOStack methodsFor: 'information' stamp: 'DR 4/25/2018 00:14:09'!
size
	^top countStackedObjects.! !

!OOStack methodsFor: 'information' stamp: 'DR 4/25/2018 00:08:10'!
top
	^top object! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'construction' stamp: 'np 4/23/2018 21:39:45'!
new
	^self basicNew initialize! !


!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'information' stamp: 'DR 4/25/2018 00:51:32'!
countStackedObjects
	self subclassResponsibility ! !

!StackElement methodsFor: 'information' stamp: 'DR 4/25/2018 00:51:46'!
isBase
	self subclassResponsibility ! !

!StackElement methodsFor: 'information' stamp: 'DR 4/25/2018 00:52:23'!
object
	self subclassResponsibility ! !

!StackElement methodsFor: 'information' stamp: 'DR 4/25/2018 00:52:29'!
objectBelow
	self subclassResponsibility ! !


!classDefinition: #StackBase category: #'Stack-Exercise'!
StackElement subclass: #StackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'information' stamp: 'DR 4/25/2018 00:15:04'!
countStackedObjects
	^ 0.! !

!StackBase methodsFor: 'information' stamp: 'np 4/23/2018 21:35:57'!
isBase
	^true! !

!StackBase methodsFor: 'information' stamp: 'DR 4/25/2018 00:17:30'!
object
	self error: OOStack stackEmptyErrorDescription! !

!StackBase methodsFor: 'information' stamp: 'DR 4/25/2018 00:16:36'!
objectBelow
	self error: OOStack stackEmptyErrorDescription! !


!classDefinition: #StackedObject category: #'Stack-Exercise'!
StackElement subclass: #StackedObject
	instanceVariableNames: 'object whatIAmStackedOver'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedObject methodsFor: 'initialization' stamp: 'DR 4/25/2018 01:13:53'!
initializeWith: anObjectToStack stackedOver: aStackedObjectToStandOver
	object := anObjectToStack.
	whatIAmStackedOver := aStackedObjectToStandOver.! !

!StackedObject methodsFor: 'initialization' stamp: 'DR 4/25/2018 01:10:24'!
with: anObjectToStack stackedOver: aStackedObjectToStandOver
	object := anObjectToStack.
	whatIAmStackedOver := aStackedObjectToStandOver.! !


!StackedObject methodsFor: 'information' stamp: 'DR 4/25/2018 00:13:49'!
countStackedObjects
	^1 + whatIAmStackedOver countStackedObjects! !

!StackedObject methodsFor: 'information' stamp: 'np 4/23/2018 21:36:07'!
isBase
	^false! !

!StackedObject methodsFor: 'information' stamp: 'DR 4/25/2018 00:07:05'!
object
	^object! !

!StackedObject methodsFor: 'information' stamp: 'DR 4/25/2018 00:06:44'!
objectBelow
	^whatIAmStackedOver! !


!StackedObject methodsFor: 'modification' stamp: 'np 4/23/2018 21:58:10'!
stackOver:  aStackedObjectToStandOver
	whatIAmStackedOver := aStackedObjectToStandOver.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackedObject class' category: #'Stack-Exercise'!
StackedObject class
	instanceVariableNames: ''!

!StackedObject class methodsFor: 'construction' stamp: 'DR 4/25/2018 01:14:31'!
with: anObjectToStack stackedOver: aStackedObjectToStandOver
	^self basicNew initializeWith: anObjectToStack stackedOver: aStackedObjectToStandOver! !
