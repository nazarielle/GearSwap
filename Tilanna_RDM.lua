-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Defense', 'Refresh')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant', 'MP')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"
    gear.default.obi_back = "Toro Cape"
    gear.default.obi_ring = "Fenrir Ring"
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {
        body="Vitivation Tabard"
    }
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +1"
        --body="Atrophy Tabard +1",
        --hands="Yaoyotl Gloves",
        --back="Refraction Cape",
        --legs="Hagondes Pants +1",
        --feet="Hagondes Sabots"
    }
    
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- need 50% to cap as RDM main (30% from traits)
    sets.precast.FC = {
        ammo="Impatiens",
        head="Atrophy Chapeau +1", -- 12%
        body="Vitivation Tabard", -- 12%
        hands="Gendewitha Gages", -- 7%
        ear2="Loquacious Earring", -- 2%
        ring1="Weatherspoon Ring", -- 5%
        ring2="Veneficium Ring",
        back="Swith Cape", -- 3%
        waist="Witful Belt", -- 3%
        legs="Orvail Pants +1", -- 5%
        feet={
            name="Telchine Pigaches",
            augments={
                '"Fast Cast"+3'
            }
        }, -- 3%
    }

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        head=empty,
        body="Twilight Cloak"
    })
    
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Yetshila",
        head="Taeon Chapeau",
        body="Taeon Tabard",
        hands="Taeon Gloves",
        legs="Taeon Tights",
        feet="Taeon Boots",
        neck="Fotia Gorget",
        waist="Windbuffet Belt",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        --ear1="Moonshade Earring",
        --ear2="Brutal Earring",
        ring1="Enlivened Ring",
        ring2="Rajas Ring",
        back="Atheling Mantle"
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        --neck="Soil Gorget",
        --ear1="Brutal Earring",
        --ear2="Moonshade Earring",
        --ring1="Aquasoul Ring",
        --ring2="Aquasoul Ring",
        --waist="Soil Belt"
    })

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Witchstone",
        head="Helios Band",
        body="Hagondes Coat +1",
        hands="Otomi Gloves",
        legs="Hagondes Pants +1",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist="Aswang Sash",
        ear1="Hecate's Earring",
        ear2="Friomisi Earring",
        ring1="Fenrir Ring",
        ring2="Acumen Ring",
        back="Toro Cape",
    }
    
    sets.precast.WS['Aeolian Edge'] = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Chant du Cygne'] = {
        ammo="Yetshila",
        head="Taeon Chapeau",
        body="Taeon Tabard",
        hands="Taeon Gloves",
        legs="Taeon Tights",
        feet="Taeon Boots",
        neck="Fotia Gorget",
        waist="Windbuffet Belt",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        --ear1="Spellbreaker Earring",
        --ear2="Brutal Earring",
        ring1="Enlivened Ring",
        ring2="Rajas Ring",
        back="Rancorous Mantle"
    }

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        main="Tamaxchi", -- 22%
        sub="Sors Shield", -- 3%
        ammo="Mana Ampulla",
        head="Gendewitha Caubeen", -- 10%
        neck="Colossus's Torque", -- 7
        body="Vitivation Tabard", -- 17
        hands="Telchine Gloves", -- 10%
        legs="Atrophy Tights +1", -- 13, 10%
        feet={
            name="Telchine Pigaches",
            augments={
                '"Cure" potency +7%',
                '"Regen" potency +2'
            }
        }, -- 7%
        back="Errant Cape",
        waist="Bishop's Sash", -- 5
        ear1="Beatific Earring", -- 4
        ear2="Roundel Earring", -- 5%
        ring1="Haoma's Ring", -- 8
        ring2="Sirona's Ring", -- 10
    }
    
    sets.midcast.Curaga = sets.midcast.Cure
    sets.midcast.CureSelf = {
        hands="Buremte Gloves",
    }
    
    sets.midcast.Cursna = {
        head="Gendewitha Caubeen",
        neck="Malison Medallion",
        body="Vitivation Tabard",
        legs="Atrophy Tights +1",
        feet="Gendewitha Galoshes",
        back="Oretania's Cape +1",
        waist="Bishop's Sash",
        ear1="Beatific Earring",
        ring1="Haoma's Ring",
        ring2="Sirona's Ring",
    }
    
    sets.midcast.StatusRemoval = {
        head="Gendewitha Caubeen",
        neck="Colossus's Torque",
        body="Vitivation Tabard",
        legs="Atrophy Tights +1",
        feet="Gendewitha Galoshes",
        back="Altruistic Cape",
        waist="Bishop's Sash",
        ear1="Beatific Earring",
        ring1="Haoma's Ring",
        ring2="Sirona's Ring",
    }
    
    sets.midcast.Regen = {
        body="Telchine Chasuble",
        feet="Telchine Pigaches" -- 2
    }

    sets.midcast['Enhancing Magic'] = {
        main="Pukulatmuj", -- 10
        neck="Colossus's Torque", -- 7
        body="Vitivation Tabard", -- 17
        hands="Atrophy Gloves +1", -- 16%
        legs="Atrophy Tights +1", -- 17
        feet="Lethargy Houseaux", -- 20, 25%
        waist="Olympus Sash", -- 5
        back="Ghostfyre Cape", -- 10, 18%
        ear1="Augmenting Earring", -- 3
    }

    sets.midcast.Refresh = {
        legs="Lethargy Fuseau"
    }

    sets.midcast.Stoneskin = {
        legs="Haven Hose",
        ear1="Earthcry Earring",
        back="Ghostfyre Cape",
        --waist="Siegel Sash"
    }
    
    sets.midcast.Protect = {
        ring2="Sheltered Ring"
    }
    
    sets.midcast.Shell = {
        ring2="Sheltered Ring"
    }
    
    sets.midcast['Enfeebling Magic'] = {
        main="Lehbrailg +2",
        sub="Mephitis Grip",
        range="Aureole",
        head="Vitivation Chapeau",
        neck="Weike Torque",
        body="Lethargy Sayon",
        hands="Hagondes Cuffs +1",
        waist="Ovate Rope",
        legs="Lethargy Fuseau",
        feet="Vitivation Boots",
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
        ring1="Weatherspoon Ring",
        ring2="Perception Ring",
        back="Ghostfyre Cape",
    }
    
    sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'], {
        body="Atrophy Tabard"
    })

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {
        head="Vitivation Chapeau"
    })

    sets.midcast['Bio III'] = set_combine(sets.midcast['Enfeebling Magic'], {
        legs="Vitivation Tights"
    })
    
    sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {
        feet="Vitivation Boots"
    })

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {
        head="Vitivation Chapeau"
    })

    sets.midcast['Blind II'] = set_combine(sets.midcast['Enfeebling Magic'], {
        legs="Vitivation Tights"
    })
    
    sets.midcast['Phalanx II'] = set_combine(sets.midcast['Enhancing Magic'], {
        hands="Vitivation Gloves"
    })
    
    sets.midcast['Elemental Magic'] = {
        main="Marin Staff",
        sub="Zuuxowu Grip",
        ammo="Ghastly Tathlum +1",
        head="Lethargy Chappel",
        body="Hagondes Coat +1",
        hands="Otomi Gloves",
        legs="Hagondes Pants +1",
        feet="Helios Boots",
        neck="Eddy Necklace",
        waist=gear.ElementalObi,
        ear1="Hecate's Earring",
        ear2="Friomisi Earring",
        ring1=gear.ElementalRing,
        ring2="Acumen Ring",
        back=gear.default.obi_back,
    }
    
    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        main="Lehbrailg +2",
        sub="Wizzan Grip",
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
    })
    
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Twilight Cloak"
    })

    sets.midcast['Dark Magic'] = {
        main="Lehbrailg +2",
        sub="Wizzan Grip",
        ammo="Ghastly Tathlum +1",
        head="Helios Band",
        body="Hagondes Coat +1",
        hands="Otomi Gloves",
        legs="Hagondes Pants +1",
        feet="Vitivation Boots",
        neck="Eddy Necklace",
        waist=gear.ElementalObi,
        ear1="Abyssal Earring",
        ear2="Friomisi Earring",
        ring1=gear.ElementalRing,
        ring2="Acumen Ring",
        back=gear.ElementalCape,
    }

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        ear1="Psystorm Earring",
        ear2="Lifestorm Earring",
    })

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ring2="Excelsis Ring",
    })

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {
        hands="Atrophy Gloves +1", -- 16%
        back="Ghostfyre Cape", -- 18%
        feet="Lethargy Houseaux", -- 25%
    }
    
    sets.buff.ComposureOther = {
        head="Lethargy Chappel",
        body="Lethargy Sayon",
        legs="Lethargy Fuseau",
        feet="Lethargy Houseaux"
    }

    sets.buff.Saboteur = {
        hands="Lethargy Gantherots"
    }
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        main="Chatoyant Staff",
    }
    
    -- Idle sets
    sets.idle = {
        main="Bolelabunga",
        sub="Beatific Shield +1",
        ammo="Homiliary",
        head="Vitivation Chapeau",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Crimson Cuisses",
        feet="Telchine Pigaches",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }

    sets.idle.PDT = {
        main="Bolelabunga",
        sub="Genbu's Shield",
        range="Phulax Bow",
        head="Vitivation Chapeau",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Crimson Cuisses",
        feet="Telchine Pigaches",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }

    sets.idle.MDT = {
        main="Bolelabunga",
        sub="Beatific Shield +1",
        range="Phulax Bow",
        head="Vitivation Chapeau",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Crimson Cuisses",
        feet="Telchine Pigaches",
        neck="Twilight Torque",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Errant Cape"
    }
    
    -- Defense sets
    sets.defense.PDT = {
        main="Claidheamh Soluis",
        sub="Genbu's Shield",
        range="Phulax Bow",
        head="Vitivation Chapeau",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Crimson Cuisses",
        feet="Telchine Pigaches",
        neck="Wiglen Gorget",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Umbra Cape"
    }

    sets.defense.MDT = {
        main="Claidheamh Soluis",
        sub="Beatific Shield +1",
        range="Phulax Bow",
        head="Vitivation Chapeau",
        body="Hagondes Coat +1",
        hands="Hagondes Cuffs +1",
        legs="Crimson Cuisses",
        feet="Telchine Pigaches",
        neck="Twilight Torque",
        waist="Aswang Sash",
        ear1="Colossus's Earring",
        ear2="Loquacious Earring",
        ring1="Defending Ring",
        ring2="Sheltered Ring",
        back="Errant Cape"
    }

    sets.Kiting = {
        legs="Crimson Cuisses"
    }

    sets.latent_refresh = {
        --waist="Fucho-no-obi"
    }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        main="Claidheamh Soluis",
        sub="Beatific Shield +1",
        ammo="Paeapua",
        head="Taeon Chapeau",
        body="Taeon Tabard",
        hands="Taeon Gloves",
        legs="Taeon Tights",
        feet="Taeon Boots",
        neck="Asperity Necklace",
        waist="Windbuffet Belt",
        ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
        ring1="Enlivened Ring",
        ring2="Rajas Ring",
        back="Atheling Mantle"
    }

    sets.engaged.Defense = sets.engaged
    
    sets.engaged.Refresh = sets.idle

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if spell.name == "Stoneskin" then
            equip(sets.midcast.Stoneskin)
        end
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 3)
end

