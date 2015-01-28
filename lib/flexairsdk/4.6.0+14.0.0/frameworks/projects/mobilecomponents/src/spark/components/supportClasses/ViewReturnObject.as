////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2010 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package spark.components.supportClasses
{
/**
 *  The ViewReturnObject class encapsulates the return value of a view 
 *  when it is popped off a navigation stack.  
 *  The ViewReturnObject object contains a reference to the 
 *  returned object, and the context in which the popped view was created.  
 *  The context is an arbitrary object that is passed to the
 *  <code>ViewNavigator.pushView()</code> method.
 * 
 *  @see spark.components.View
 *  @see spark.components.ViewNavigator#pushView()
 * 
 *  @langversion 3.0
 *  @playerversion AIR 2.5
 *  @productversion Flex 4.5
 */
public class ViewReturnObject
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    
    /**
     *  Constructor.
     * 
     *  @param object The returned object.
     * 
     *  @param context The context in which the owner was created.
     * 
     *  @langversion 3.0
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */
    public function ViewReturnObject(object:Object = null, context:Object = null)
    {
        super();
        
        this.object = object;
        this.context = context;
    }
    
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    //----------------------------------
    //  context
    //----------------------------------
    
    /**
     *  The context identifier passed to the popped view when it was pushed
     *  onto the navigation stack.
     * 
     *  @see spark.components.ViewNavigator#pushView()
     * 
     *  @langversion 3.0
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */
    public var context:Object = null;
    
    //----------------------------------
    //  object
    //----------------------------------
    
    /**
     *  The return object generated by the view that is being removed.
     * 
     *  @langversion 3.0
     *  @playerversion AIR 2.5
     *  @productversion Flex 4.5
     */
    public var object:Object = null;
}
}