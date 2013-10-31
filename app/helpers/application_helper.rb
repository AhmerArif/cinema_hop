module ApplicationHelper

def humanize_is_3d(boolean)
    boolean ? '3D' : '2D'
end

def humanize_adults_only(boolean)
    boolean ? 'Adults Only' : ''
end

end