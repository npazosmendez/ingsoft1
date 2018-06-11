!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'support' stamp: 'DR 6/10/2018 13:20:58'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTest methodsFor: 'support' stamp: 'DR 6/10/2018 17:08:07'!
createCartWithItem
	
	| cart |
	
	cart _ self createCart.
	cart add: self itemSellByTheStore.
	
	^cart! !

!TusLibrosTest methodsFor: 'support' stamp: 'np 6/11/2018 00:48:03'!
createCartWithItemPriced: aPrice
	
	| cart catalog |
	
	catalog _ Dictionary with: self itemSellByTheStore->aPrice.
	cart _ Cart acceptingItemsOf: catalog.
	cart add: self itemSellByTheStore.
	
	^cart! !

!TusLibrosTest methodsFor: 'support' stamp: 'np 6/11/2018 00:53:04'!
defaultCatalog
	
	^ Dictionary with: (self itemSellByTheStore)->10! !

!TusLibrosTest methodsFor: 'support' stamp: 'DR 6/7/2018 19:43:00'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'DR 6/7/2018 19:43:09'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTest methodsFor: 'support' stamp: 'DR 6/10/2018 16:58:28'!
should: aBlock raise: anExceptonHandlingCondition withMessage: anErrorMessage
	
	self
		should: aBlock
		raise: anExceptonHandlingCondition
		withExceptionDo: [ :anError | self assert: anError messageText equals: anErrorMessage ]! !

!TusLibrosTest methodsFor: 'support' stamp: 'np 6/11/2018 00:28:24'!
unexpiredCreditCard

	^CreditCard withExpirationDate: FixedGregorianDate tomorrow.! !


!classDefinition: #CartTest category: #TusLibros!
TusLibrosTest subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'np 6/11/2018 00:17:54'!
test09EmptyCartTotalCostIsZero

	self assert: self createCart totalCost  equals: 0.! !

!CartTest methodsFor: 'tests' stamp: 'np 6/11/2018 00:49:17'!
test10NonEmptyCartComputesTotalCost
	
	| cart |
	
	cart _ self createCartWithItemPriced: 63.
	
	self assert: cart totalCost  equals: 63.! !


!classDefinition: #CashierTest category: #TusLibros!
TusLibrosTest subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'np 6/11/2018 00:52:00'!
test01CashierCanNotCheckoutEmptyCart

	| cart cashier creditCard |

	cart _ self createCart.
	creditCard _ self unexpiredCreditCard.
	cashier _ Cashier for: cart.
	
	self
		should: [ cashier chargeTo: creditCard ]
		raise: Error - MessageNotUnderstood
		withMessage: Cashier canNotCheckoutEmptyCartErrorMessage.
		! !

!CashierTest methodsFor: 'tests' stamp: 'np 6/11/2018 00:53:14'!
test02CashierCheckoutsCartWithItemsAndReturnsBill

	| bill cart cashier creditCard |
	
	cart _ self createCartWithItemPriced: 10.
	creditCard _ self unexpiredCreditCard.
	cashier _ Cashier for: cart.
		
	bill _ cashier chargeTo: creditCard.
	
	self assert: bill equals: 10.! !

!CashierTest methodsFor: 'tests' stamp: 'np 6/11/2018 01:03:43'!
test03CashierCanNotCheckoutFromExpiredCreditCard

	| cart cashier expiredCreditCard |
	
	cart _ self createCartWithItem.
	expiredCreditCard _ CreditCard withExpirationDate: FixedGregorianDate yesterday.
	cashier _ Cashier for: cart.
	
	self
		should: [ cashier chargeTo: expiredCreditCard ]
		raise: Error - MessageNotUnderstood
		withMessage: Cashier canNotCheckoutWithExpiredCreditCardErrorMessage.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'np 6/11/2018 00:04:16'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'cost' stamp: 'np 6/11/2018 00:56:18'!
totalCost

	^ items inject: 0 into: [ :total :item | total + catalog at: item ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'assertions' stamp: 'DR 6/10/2018 17:10:11'!
assertCartIsNotEmpty: aCart

	aCart isEmpty ifTrue: [ self error: self class canNotCheckoutEmptyCartErrorMessage ].! !

!Cashier methodsFor: 'assertions' stamp: 'DR 6/10/2018 17:10:15'!
assertCreditCardIsNotExpired: aCreditCard

	aCreditCard isExpired ifTrue: [ self error: self class canNotCheckoutWithExpiredCreditCardErrorMessage ].! !


!Cashier methodsFor: 'initialization' stamp: 'np 6/11/2018 01:04:34'!
initializeFor: aCart 

	cart _ aCart.! !


!Cashier methodsFor: 'checkout' stamp: 'np 6/11/2018 00:40:26'!
chargeTo: aCreditCard

	| total |
	
	self assertCartIsNotEmpty: cart.
	self assertCreditCardIsNotExpired: aCreditCard.
	
	total _ cart totalCost.
	
	self debit: total from: aCreditCard.
	
	^ total.! !

!Cashier methodsFor: 'checkout' stamp: 'DR 6/7/2018 20:51:04'!
debit: ammount from: aCreditCard
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'DR 6/10/2018 17:09:49'!
canNotCheckoutEmptyCartErrorMessage

	^'Can not cash empty cart'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'DR 6/10/2018 17:09:54'!
canNotCheckoutWithExpiredCreditCardErrorMessage

	^'Can not cash with expired credit card'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'np 6/11/2018 01:04:28'!
for: aCart

	^self new initializeFor: aCart! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'DR 6/10/2018 16:43:37'!
initializeWithExpirationDate: anExpirationDate

	expirationDate _ anExpirationDate! !


!CreditCard methodsFor: 'expiration' stamp: 'DR 6/10/2018 16:43:34'!
isExpired

	^FixedGregorianDate today > expirationDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'DR 6/10/2018 16:43:32'!
withExpirationDate: anExpirationDate

	^self new initializeWithExpirationDate: anExpirationDate.! !
