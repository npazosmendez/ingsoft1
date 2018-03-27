!classDefinition: #Cleaner category: #Peano!
DenotativeObject subclass: #Cleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cleaner class' category: #Peano!
Cleaner class
	instanceVariableNames: ''!

!Cleaner class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:40:05'!
clean
	| cur next |
	
	II isLast ifTrue: [ cur := nil ] ifFalse: [ cur := II next ].
	II next: nil.
	
	[cur == nil] whileFalse: [
		cur isLast ifTrue: [ next := nil ] ifFalse: [ next := cur next ].
		cur removeFromSystem.
		cur := next.
		].! !


!classDefinition: #I category: #Peano!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #Peano!
I class
	instanceVariableNames: 'previous next'!

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:45:42'!
* pn
	^pn! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:42:39'!
+ pn
	^pn next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:34:45'!
- pn
	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:34:32'!
/ pn
	| response |
	
	self < pn
		ifTrue: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	pn == I
		ifTrue: [ response := self ].
	
	self == pn
		ifTrue: [ response := I ]
		ifFalse: [ response :=(self - pn) / pn + I ].
	
	^response! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:20:38'!
< pn
	| resultado |
		
	(self == pn or: pn == I) 
	ifTrue: [ resultado := false ]
	ifFalse: [
		self == I
		ifTrue: [ resultado := true ]
		ifFalse: [ resultado := self previous < pn previous ]
	].

	^resultado! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:07:36'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'OtraDesc'! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:07:25'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'Desc'! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:13:54'!
isLast
	^next == nil! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/24/2018 23:22:51'!
next
	next ifNil: [
		next := self cloneNamed: ((self name), #I).
		next previous: self
	].
	^next! !

!I class methodsFor: 'as yet unclassified' stamp: 'DR 3/24/2018 23:36:51'!
previous
	self error: 'I has no previous'.! !


!I class methodsFor: 'nil' stamp: 'DR 3/26/2018 20:03:17'!
subtractTo: pn
	
	^pn previous! !

I instVarNamed: 'previous' put: nil!
I instVarNamed: 'next' put: II!

!classDefinition: #II category: #Peano!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #Peano!
II class
	instanceVariableNames: 'previous next'!

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:49:14'!
* pn
	^self previous * pn + pn! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:44:52'!
+ pn
	^self previous + pn next! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 20:37:36'!
- pn
	^pn subtractTo: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:34:22'!
/ pn
	| response |
	
	self < pn
		ifTrue: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	pn == I
		ifTrue: [ response := self ].
	
	self == pn
		ifTrue: [ response := I ]
		ifFalse: [ response :=(self - pn) / pn + I ].
	
	^response! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:20:52'!
< pn
	| resultado |
		
	(self == pn or: pn == I) 
	ifTrue: [ resultado := false ]
	ifFalse: [
		self == I
		ifTrue: [ resultado := true ]
		ifFalse: [ resultado := self previous < pn previous ]
	].

	^resultado! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:23:31'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'OtraDesc'! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:23:40'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'Desc'! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:14:19'!
isLast
	^next == nil! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/24/2018 23:36:21'!
next
	next ifNil: [
		next := self cloneNamed: ((self name), #I).
		next previous: self
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/25/2018 00:19:22'!
next: pn
	next := pn! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/24/2018 23:36:21'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'DR 3/24/2018 23:36:21'!
previous: pn
	previous := pn! !


!II class methodsFor: 'nil' stamp: 'DR 3/26/2018 20:36:31'!
subtractTo: pn

	^(previous subtractTo: pn previous)! !

II instVarNamed: 'previous' put: I!
II instVarNamed: 'next' put: III!

!classDefinition: #III category: #Peano!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #Peano!
III class
	instanceVariableNames: 'previous next'!

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
* pn
	^self previous * pn + pn! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
+ pn
	^self previous + pn next! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
- pn
	^pn subtractTo: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
/ pn
	| response |
	
	self < pn
		ifTrue: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	pn == I
		ifTrue: [ response := self ].
	
	self == pn
		ifTrue: [ response := I ]
		ifFalse: [ response :=(self - pn) / pn + I ].
	
	^response! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
< pn
	| resultado |
		
	(self == pn or: pn == I) 
	ifTrue: [ resultado := false ]
	ifFalse: [
		self == I
		ifTrue: [ resultado := true ]
		ifFalse: [ resultado := self previous < pn previous ]
	].

	^resultado! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'OtraDesc'! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'Desc'! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
isLast
	^next == nil! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
next
	next ifNil: [
		next := self cloneNamed: ((self name), #I).
		next previous: self
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
next: pn
	next := pn! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
previous: pn
	previous := pn! !


!III class methodsFor: 'nil' stamp: 'DR 3/26/2018 21:35:32'!
subtractTo: pn

	^(previous subtractTo: pn previous)! !

III instVarNamed: 'previous' put: II!
III instVarNamed: 'next' put: IIII!

!classDefinition: #IIII category: #Peano!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #Peano!
IIII class
	instanceVariableNames: 'previous next'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
* pn
	^self previous * pn + pn! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
+ pn
	^self previous + pn next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
- pn
	^pn subtractTo: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
/ pn
	| response |
	
	self < pn
		ifTrue: [ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	
	pn == I
		ifTrue: [ response := self ].
	
	self == pn
		ifTrue: [ response := I ]
		ifFalse: [ response :=(self - pn) / pn + I ].
	
	^response! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
< pn
	| resultado |
		
	(self == pn or: pn == I) 
	ifTrue: [ resultado := false ]
	ifFalse: [
		self == I
		ifTrue: [ resultado := true ]
		ifFalse: [ resultado := self previous < pn previous ]
	].

	^resultado! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor

	^'OtraDesc'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
descripcionDeErrorDeNumerosNegativosNoSoportados

	^'Desc'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
isLast
	^next == nil! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
next
	next ifNil: [
		next := self cloneNamed: ((self name), #I).
		next previous: self
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
next: pn
	next := pn! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'DR 3/26/2018 21:35:32'!
previous: pn
	previous := pn! !


!IIII class methodsFor: 'nil' stamp: 'DR 3/26/2018 21:35:32'!
subtractTo: pn

	^(previous subtractTo: pn previous)! !

IIII instVarNamed: 'previous' put: III!
IIII instVarNamed: 'next' put: nil!