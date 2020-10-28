"""
	start_counters(events)

Start counting hardware events.  This function cannot be called if the counters have already been started.
"""
function start_counters(evts::Vector{Event})
    nevts = length(evts)
    if nevts == 0
        throw(ArgumentError("one or more PAPI.Events required"))
	end

    ncounters = num_counters()
    if nevts > ncounters
        throw(ArgumentError("number of PAPI.Events must be ≤ PAPI.num_counters(), got $nevts"))
	end

    @papichk ccall((:PAPI_start_counters, :libpapi), Cint, (Ptr{Cuint}, Cint), evts, nevts)
    return
end

start_counters(evts::Event...) = start_counters(collect(evts))

"""
	read_counters!(values::Vector{Clonglong})

Read and reset counters.
``read_counters!`` copies the event counters into values. The counters are reset and left running after the call.
"""
function read_counters!(values::Vector{Clonglong})
	@papichk ccall((:PAPI_read_counters, :libpapi), Cint, (Ptr{Clonglong}, Cint), values, length(values))
	values
end

"""
	accum_counters!(values::Vector{Clonglong})

Accumulate and reset counters.
``accum_counters!`` accumulates the event counters into values. The counters are reset and left running after the call.
"""
function accum_counters!(values::Vector{Clonglong})
    @papichk ccall((:PAPI_read_counters, :libpapi), Cint, (Ptr{Clonglong}, Cint), values, length(values))
end

"""
	stop_counters!(values::Vector{Clonglong})

Stop counters and return current counts.
The counters must have been started by a previous call to ``start_counters``
"""
function stop_counters!(values::Vector{Clonglong})
	numevents = length(values)
	@papichk ccall((:PAPI_stop_counters, :libpapi), Cint, (Ptr{Cuint}, Cint), values, numevents)
	values
end

"""
	stop_counters()

Stop counters and discard values
The counters must have been started by a previous call to ``start_counters``
"""
function stop_counters()
	@papichk ccall((:PAPI_stop_counters, :libpapi), Cint, (Ptr{Cuint}, Cint), C_NULL, 0)
	nothing
end

