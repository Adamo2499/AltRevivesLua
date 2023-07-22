local mod = RegisterMod("Alt Revives", 1)
ReviveTimer = 45

function mod:revive()
    for i, e in pairs(Isaac.FindByType(EntityType.ENTITY_PLAYER, 0, -1, false, false)) do
        local player = e:ToPlayer()
        if player:IsDead() then
            ReviveTimer = ReviveTimer - 1
            if ReviveTimer == 0 then
                if player:GetPlayerType() >= PlayerType.PLAYER_ISAAC_B then
                    if player:HasCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS) then
                        print("Player dead, reviving as Alive Tainted Lazarus...")
                        player:ChangePlayerType(PlayerType.PLAYER_LAZARUS_B)
                        player:Revive()
                        player:AddHearts(3);
                        player:AnimateCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS)
                        player:RemoveCollectible(CollectibleType.COLLECTIBLE_LAZARUS_RAGS)
                    end
                    if player:HasCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW) then
                        print("Player dead, reviving as Tainted Judas...")
                        player:ChangePlayerType(PlayerType.PLAYER_JUDAS_B)
                        player:AddMaxHearts(-24, false)
                        player:AddSoulHearts(-24)
                        player:AddBlackHearts(-24)
                        player:Revive()
                        player:AnimateCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW)
                        player:RemoveCollectible(CollectibleType.COLLECTIBLE_JUDAS_SHADOW)
                        player:AddBlackHearts(6)
                    end
                    -- Ankh
                    if player:HasCollectible(CollectibleType.ANKH) then
                        local bombsNumber = player:GetNumBombs()
                        print("Player dead, reviving as Tainted ???...")
                        player:ChangePlayerType(PlayerType.PLAYER_BLUEBABY_B)
                        player:AddMaxHearts(-24, false)
                        player:AddSoulHearts(-24)
                        player:AddBlackHearts(-24)
                        player:Revive()
                        player:RemoveCollectible(CollectibleType.COLLECTIBLE_ANKH)
                        player:AddSoulHearts(9)
                        -- Add poops to bombs conversion
                        
                    end
                    -- Missing Poster
                    if player:HasTrinket(TrinketType.TRINKET_MISSING_POSTER) then
                       print("Player dead, reviving as Tainted Lost...")
                       player:ChangePlayerType(PlayerType.PLAYER_THELOST_B)
                       player:AddCard(Card.CARD_HOLY)
                       player:AddTrinket(TrinketType.TRINKET_WOODEN_CROSS)
                       player:Revive();
                       player:TryRemoveTrinket(TrinketType.TRINKET_MISSING_POSTER)
                    end
                end
            end
        end
    end
end

mod:AddCallback(ModCallbacks.MC_POST_UPDATE, mod.revive)
