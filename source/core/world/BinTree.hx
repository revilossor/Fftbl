package core.world;

/**
 * @author Oliver Ross
 */

typedef BinTree<T> =
{
	var value:T;
	var left:BinTree<T>;
	var right:BinTree<T>;	// TODO handle end
}