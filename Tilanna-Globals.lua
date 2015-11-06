-------------------------------------------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    gs c nuke #
        Casts a nuke of the given tier
        example: gs c nuke 3
        Will cast a tier 3 nuke of the current NukeType (Blizzard III, Aero III, etc)
    
    gs c nuke # ga/ja/ra/helix/am
        Casts a nuke of the given tier of a -ga, -ja, -ra, helix, or Ancient Magic spell.
        example: gs c nuke 2 ra
        Will cast a tier 2 nuke of the current NukeType using the -ra spells (Blizzara II, Fira II, etc)
    
    
    Configuration commands:
    
    
    gs c cycle nuketype
        Cycles through the available nuke element to use as the primary nuke when using one of the above commands.
        
    gs c set nuketype Ice
        Set NukeType to the specified element (in this case, Ice)
    
    To use these in macros, make sure to use /console before the command (can be shortened to /cons),
    e.g. /console gs c nuke 6
    
--]]

sets.reive = {neck="Arciela's Grace +1"}

elements.nuke_of = {
    ['Light']="Banish",
    ['Dark']="Comet",
    ['Fire']="Fire",
    ['Earth']="Stone",
    ['Water']="Water",
    ['Wind']="Aero",
    ['Ice']="Blizzard",
    ['Lightning']="Thunder"
}

elements.nukega_of = {
    ['Light']="Banishga",
    ['Fire']="Firaga",
    ['Earth']="Stonega",
    ['Water']="Waterga",
    ['Wind']="Aeroga",
    ['Ice']="Blizzaga",
    ['Lightning']="Thundaga"
}

elements.nukeja_of = {
    ['Fire']="Firaja",
    ['Earth']="Stoneja",
    ['Water']="Waterja",
    ['Wind']="Aeroja",
    ['Ice']="Blizzaja",
    ['Lightning']="Thundaja"
}

elements.nukera_of = {
    ['Fire']="Fira",
    ['Earth']="Stonera",
    ['Water']="Watera",
    ['Wind']="Aerora",
    ['Ice']="Blizzara",
    ['Lightning']="Thundara"
}

elements.helix_of = {
    ['Light']="Luminohelix",
    ['Dark']="Noctohelix",
    ['Fire']="Pyrohelix",
    ['Earth']="Geohelix",
    ['Water']="Hydrohelix",
    ['Wind']="Anemohelix",
    ['Ice']="Cryohelix",
    ['Lightning']="Ionohelix"
}

elements.ancientmagic_of = {
    ['Fire']="Flare",
    ['Earth']="Quake",
    ['Water']="Flood",
    ['Wind']="Tornado",
    ['Ice']="Freeze",
    ['Lightning']="Burst"
}

-- map new spells that aren't in Mote's library, so that they don't get erased if the library is redownloaded and overwritten

classes.SpellMaps['Pyrohelix II']='Helix'
classes.SpellMaps['Cryohelix II']='Helix'
classes.SpellMaps['Anemohelix II']='Helix'
classes.SpellMaps['Geohelix II']='Helix'
classes.SpellMaps['Ionohelix II']='Helix'
classes.SpellMaps['Hydrohelix II']='Helix'
classes.SpellMaps['Luminohelix II']='Helix'
classes.SpellMaps['Noctohelix II']='Helix'
classes.SpellMaps['Firestorm II']='Storm'
classes.SpellMaps['Hailstorm II']='Storm'
classes.SpellMaps['Windstorm II']='Storm'
classes.SpellMaps['Sandstorm II']='Storm'
classes.SpellMaps['Thunderstorm II']='Storm'
classes.SpellMaps['Rainstorm II']='Storm'
classes.SpellMaps['Aurorastorm II']='Storm'
classes.SpellMaps['Voidstorm II']='Storm'
classes.SpellMaps['Utsusemi: San']='Utsusemi'
classes.SpellMaps['Aspir III']='Aspir'

classes.NoSkillSpells = S{
    'Haste',
    'Flurry',
    'Refresh',
    'Regen',
    'Protect',
    'Protectra',
    'Shell',
    'Shellra',
    'Raise',
    'Reraise',
    'Sneak',
    'Invisible',
    'Deodorize',
    'Aquaveil',
    'Blink',
    'Adloquium',
    'Animus Augeo',
    'Animus Minuo'
}

-- Global intercept on midcast.
function user_post_midcast(spell, action, spellMap, eventArgs)
    if buffactive['Reive Mark'] and (spell.skill == 'Elemental Magic' or spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.reive)
    end
end

function user_customize_idle_set(idleSet)
    if buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.reive)
    end
    if world.area:contains("Adoulin") then
        idleSet = set_combine(idleSet, {body="Councilor's Garb"})
    end
    return idleSet
end

function job_setup()
    state.NukeType = M{['description']='Nuke Type', 'Earth', 'Wind', 'Ice', 'Fire', 'Water', 'Lightning', 'Light', 'Dark'}
end

-------------------------------------------------------------------------------------------------------------------
-- Global Utility functions
-------------------------------------------------------------------------------------------------------------------

function handle_nuking(cmdParams)
    -- cmdParams[1] = nuke
    -- cmdParams[2] = number (tier of nuke)
    -- cmdParams[3] = ga, ja, ra for AoE, helix for helix, or am for ancient magic (or recast)
    -- cmdParams[4] = recast
    
    local fullSpell = ""
    local spellName = ""
    local spellTier = ""
    
    -- get spell name based on the third parameter
    -- if type isn't one of the known types (ga, ja, ra, helix), then default to elemental nuke
    if cmdParams[3] == "ga" then
        if elements.nukega_of[state.NukeType.current] then
            spellName = elements.nukega_of[state.NukeType.current]
        else
            add_to_chat(123,'Error: No ga spell for element ['..state.NukeType.current..']')
            return
        end
    elseif cmdParams[3] == "ja" then
        if elements.nukeja_of[state.NukeType.current] then
            spellName = elements.nukeja_of[state.NukeType.current]
        else
            add_to_chat(123,'Error: No ja spell for element ['..state.NukeType.current..']')
            return
        end
    elseif cmdParams[3] == "ra" then
        if elements.nukera_of[state.NukeType.current] then
            spellName = elements.nukera_of[state.NukeType.current]
        else
            add_to_chat(123,'Error: No ra spell for element ['..state.NukeType.current..']')
            return
        end
    elseif cmdParams[3] == "helix" then
        if elements.helix_of[state.NukeType.current] then
            spellName = elements.helix_of[state.NukeType.current]
        else
            add_to_chat(123,'Error: No helix spell for element ['..state.NukeType.current..']')
            return
        end
    elseif cmdParams[3] == "am" then
        if elements.ancientmagic_of[state.NukeType.current] then
            spellName = elements.ancientmagic_of[state.NukeType.current]
        else
            add_to_chat(123,'Error: No ancient magic spell for element ['..state.NukeType.current..']')
            return
        end
    else
        if elements.nuke_of[state.NukeType.current] then
            spellName = elements.nuke_of[state.NukeType.current]
        else
            add_to_chat(123,'Error: No nuke spell for element ['..state.NukeType.current..']')
            return
        end
    end
    
    spellTier = get_tier_roman(cmdParams[2])
    
    if spellTier then
        fullSpell = spellName.." "..spellTier
    else
        fullSpell = spellName
    end
    
    if cmdParams[3] == "recast" or cmdParams[4] == "recast" then
        send_command('@input /recast "'..fullSpell..'"')
    end
    
    send_command('@input /ma "'..fullSpell..'" <t>')
end

function get_tier_roman(numeric)
    if numeric == "1" then
        return nil
    elseif numeric == "2" then
        return "II"
    elseif numeric == "3" then
        return "III"
    elseif numeric == "4" then
        return "IV"
    elseif numeric == "5" then
        return "V"
    elseif numeric == "6" then
        return "VI"
    else
        return nil
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Test function to use to avoid modifying library files.
-------------------------------------------------------------------------------------------------------------------

function user_test(params)

end

