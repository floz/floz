package com.gobzlite.sounds 
{
	/**
	 * return a loaded gsound from lib
	 * 
	 * @param	name	sound's id in librairy
	 * @return	gsound or null if sound isn't find.
	 */
	public function getSound( name:String ):GSound
	{
		return SoundManager.getSound(name);
	}
}