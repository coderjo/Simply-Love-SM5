local player = ...
local judgments = {}
local timing_errors = {}
local total_judgements = {}

local early_steps = 0
local late_steps = 0

for i=1,GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() do
	judgments[#judgments+1] = { W1=0, W2=0, W3=0, W4=0, W5=0, Miss=0 }
end

return Def.Actor{
    JudgmentMessageCommand=function(self, params)
		if params.Player == player and params.Notes then
			for i,col in pairs(params.Notes) do
				local tns = ToEnumShortString(params.TapNoteScore)
				judgments[i][tns] = judgments[i][tns] + 1
			end
			
			total_judgements[#total_judgements + 1] = params

			local fTapNoteOffset = params.TapNoteOffset;
			--------------
			if params.HoldNoteScore then
				fTapNoteOffset = 1;
			end
			--------------
			if params.TapNoteScore == 'TapNoteScore_Miss' then
				fTapNoteOffset = 1;
			end
			--------------
			if fTapNoteOffset ~= 1 then
				timing_errors[#timing_errors+1] = math.abs(fTapNoteOffset);

				if params.TapNoteScore ~= 'TapNoteScore_W1' then
					if params.TapNoteOffset > 0 then 
						late_steps = late_steps + 1;
					else
						early_steps = early_steps + 1;  
					end
				end
			end
			--------------
		end
    end,
	OffCommand=function(self)
		local storage = SL[ToEnumShortString(player)].Stages.Stats[SL.Global.Stages.PlayedThisGame + 1]
		storage.column_judgments = judgments
		storage.timing_errors = timing_errors
		storage.total_judgements = total_judgements
		storage.early_steps = early_steps
		storage.late_steps = late_steps
	end
}