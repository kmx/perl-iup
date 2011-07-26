#L<MAP_CB|../call/iup_map_cb.html>
#>>
#L<MAP_CB|[%m.cb%]/IUP_MAP_CB>,

#L<CURSORPOS|../attrib/iup_globals.html#cursorpos>. 

use strict;
use warnings;

use File::Slurp;
use File::Glob 'bsd_glob';
use FindBin;
use File::Basename;

my @files =  bsd_glob("$FindBin::Bin/pod.tt/*.pod");

#for debug
my $DBG = 0;
@files = ( 'IUP_AAA.pod' ) if $DBG;

warn "total.count=", scalar(@files), "\n";
my @changed;

for my $f (@files) {
  my $txt = read_file($f, {binmode=>':raw'} );
  my $new = $txt;  
  ### do the fix
  my $ucf = ucfirst basename($f);
  $ucf =~ s/\.pod$//;
  $ucf =~ s/^iup_//i;
  my $lcf = lc($ucf);
  
  my $txtorig = <<'ORIG';
=back

[% txt.at_common %]

=over
ORIG
  my $txtex = <<'XXX';
[% IF examples.iupX_X_X_SMALL %]
The element B<IUP::X_X_X_BIG> is used in the following sample scripts:

=over
[%FOREACH e IN examples.iupX_X_X_SMALL %]
=item * L<[%e.pl%]|[%url.examples%][%e.pl%]>[%e.desc%]
[%END%]
=back 

[%ELSE%]
Unfortunately there are no sample scripts using this element.

[%END%]
XXX
  #$new =~ s!=item *\* *B\<ih\> *- *identifier of the element that activated the event\.!B<\$self:> reference to the element (IUP::XXX$ucf) that activated the event!sgi;
  #$new =~ s!\n\n*[^\n]*common callbacks are supported\.?\n\n*=back!\n\n=back!sgi;
  #$new =~ s!^Returns:\s*!B<Returns:> !mi;
  #$new =~ s!^=item \* B<([a-z0-9]+)>!B<\$$1:>!m;
  #$new =~ s!^(B<.*?>) *- *!$1 !m;
  #$new =~ s!^XXX-ODOC-XXX\n!$txtorig!m;
  #$new =~ s!iupX_X_X_SMALL!iup$lcf!sg;
  
  ##$new =~ s![LB]<IUP::Alarm(\|IUP::Alarm)?>!L<Alarm|IUP/"Alarm()">!sg;
  ##$new =~ s![LB]<IUP::Append(\|IUP::Append)?>!L<Append|[%m.elem%]/"Append()">!sg;
  ##$new =~ s![LB]<IUP::ConvertXYToPos(\|IUP::ConvertXYToPos)?>!L<ConvertXYToPos|[%m.elem%]/"ConvertXYToPos()">!sg;
  ##$new =~ s![LB]<IUP::ConvertXYToPos(\|IUP::ConvertXYToPos)?>!L<ConvertXYToPos|[%m.elem%]/"ConvertXYToPos()">!sg;
  ##$new =~ s![LB]<IUP::Create(\|IUP::Create)?>!L<Create|[%m.elem%]/"Create()">!sg;
  ##$new =~ s![LB]<IUP::Destroy(\|IUP::Destroy)?>!L<Destroy|[%m.elem%]/"Destroy()">!sg;
  ##$new =~ s![LB]<IUP::Detach(\|IUP::Detach)?>!L<Detach|[%m.elem%]/"Detach()">!sg;
  ##$new =~ s![LB]<IUP::ExitLoop(\|IUP::ExitLoop)?>!L<ExitLoop|IUP/"ExitLoop()">!sg;
  ##$new =~ s![LB]<IUP::Flush(\|IUP::Flush)?>!L<Flush|[%m.elem%]/"Flush()">!sg;
  ##$new =~ s![LB]<IUP::GetAttribute(\|IUP::GetAttribute)?>!L<GetAttribute|[%m.elem%]/"GetAttribute()">!sg;
  ##$new =~ s![LB]<IUP::GetBrother(\|IUP::GetBrother)?>!L<GetBrother|[%m.elem%]/"GetBrother()">!sg;
  ##$new =~ s![LB]<IUP::GetChild(\|IUP::GetChild)?>!L<GetChild|[%m.elem%]/"GetChild()">!sg;
  ##$new =~ s![LB]<IUP::GetChildCount(\|IUP::GetChildCount)?>!L<GetChildCount|[%m.elem%]/"GetChildCount()">!sg;
  ##$new =~ s![LB]<IUP::GetColor(\|IUP::GetColor)?>!L<GetColor|IUP/"GetColor()">!sg;
  ##$new =~ s![LB]<IUP::GetDialog(\|IUP::GetDialog)?>!L<GetDialog|[%m.elem%]/"GetDialog()">!sg;
  ##$new =~ s![LB]<IUP::GetDialogChild(\|IUP::GetDialogChild)?>!L<GetDialogChild|[%m.elem%]/"GetDialogChild()">!sg;
  ##$new =~ s![LB]<IUP::GetFile(\|IUP::GetFile)?>!L<GetFile|IUP/"GetFile()">!sg;
  ##$new =~ s![LB]<IUP::GetFocus(\|IUP::GetFocus)?>!L<GetFocus|IUP/"GetFocus()">!sg;
  ##$new =~ s![LB]<IUP::GetNextChild(\|IUP::GetNextChild)?>!L<GetNextChild|[%m.elem%]/"GetNextChild()">!sg;
  ##$new =~ s![LB]<IUP::GetParent(\|IUP::GetParent)?>!L<GetParent|[%m.elem%]/"GetParent()">!sg;
  ##$new =~ s![LB]<IUP::Hide(\|IUP::Hide)?>!L<Hide|[%m.elem%]/"Hide()">!sg;
  ##$new =~ s![LB]<IUP::Insert(\|IUP::Insert)?>!L<Insert|[%m.elem%]/"Insert()">!sg;
  ##$new =~ s![LB]<IUP::ListDialog(\|IUP::ListDialog)?>!L<ListDialog|IUP/"ListDialog>()">!sg;
  ##$new =~ s![LB]<IUP::LoopStep(\|IUP::LoopStep)?>!L<LoopStep|IUP/"LoopStep()">!sg;
  ##$new =~ s![LB]<IUP::MainLoop(\|IUP::MainLoop)?>!L<MainLoop|IUP/"MainLoop()">!sg;
  ##$new =~ s![LB]<IUP::Map(\|IUP::Map)?>!L<Map|[%m.elem%]/"Map()">!sg;
  ##$new =~ s![LB]<IUP::Message(\|IUP::Message)?>!L<Message|IUP/"Message()">!sg;
  ##$new =~ s![LB]<IUP::NextField(\|IUP::NextField)?>!L<NextField|[%m.elem%]/"NextField()">!sg;
  ##$new =~ s![LB]<IUP::PPlotAdd (\|IUP::PPlotAdd )?>!L<PlotAdd |IUP::PPlot/"PlotAdd ()">!sg;
  ##$new =~ s![LB]<IUP::PPlotBegin(\|IUP::PPlotBegin)?>!L<PlotBegin|IUP::PPlot/"PlotBegin()">!sg;
  ##$new =~ s![LB]<IUP::PPlotTransform(\|IUP::PPlotTransform)?>!L<PlotTransform|IUP::PPlot/"PlotTransform()">!sg;
  ##$new =~ s![LB]<IUP::Popup(\|IUP::Popup)?>!L<Popup|[%m.elem%]/"Popup()">!sg;
  ##$new =~ s![LB]<IUP::PreviousField(\|IUP::PreviousField)?>!L<PreviousField|[%m.elem%]/"PreviousField()">!sg;
  ##$new =~ s![LB]<IUP::Refresh(\|IUP::Refresh)?>!L<Refresh|[%m.elem%]/"Refresh()">!sg;
  ##$new =~ s![LB]<IUP::Reparent(\|IUP::Reparent)?>!L<Reparent|[%m.elem%]/"Reparent()">!sg;
  ##$new =~ s![LB]<IUP::Scanf(\|IUP::Scanf)?>!L<GetParam|IUP/"GetParam()">!sg;
  ##$new =~ s![LB]<IUP::SetAttribute(\|IUP::SetAttribute)?>!L<SetAttribute|[%m.elem%]/"SetAttribute()">!sg;
  ##$new =~ s![LB]<IUP::SetAttributeHandle(\|IUP::SetAttributeHandle)?>!XXX-FIX_ME!sg;
  ##$new =~ s![LB]<IUP::SetCallback(\|IUP::SetCallback)?>!L<SetCallback|[%m.elem%]/"SetCallback()">!sg;
  ##$new =~ s![LB]<IUP::SetFocus(\|IUP::SetFocus)?>!L<SetFocus|[%m.elem%]/"SetFocus()">!sg;
  ##$new =~ s![LB]<IUP::SetFunction(\|IUP::SetFunction)?>!L<SetFunction|[%m.elem%]/"SetFunction()">!sg;
  ##$new =~ s![LB]<IUP::SetHandle(\|IUP::SetHandle)?>!L<SetName|[%m.elem%]/"SetName()">!sg;
  ##$new =~ s![LB]<IUP::SetLanguage(\|IUP::SetLanguage)?>!L<SetLanguage|IUP/"SetLanguage()">!sg;
  ##$new =~ s![LB]<IUP::Show(\|IUP::Show)?>!L<Show|[%m.elem%]/"Show()">!sg;
  ##$new =~ s![LB]<IUP::ShowXY(\|IUP::ShowXY)?>!L<ShowXY|[%m.elem%]/"ShowXY()">!sg;
  ##$new =~ s![LB]<IUP::StoreAttribute(\|IUP::StoreAttribute)?>!L<StoreAttribute|[%m.elem%]/"StoreAttribute()">!sg;
  ##$new =~ s![LB]<IUP::Unmap(\|IUP::Unmap)?>!L<Unmap|[%m.elem%]/"Unmap()">!sg;
  ##$new =~ s![LB]<IUP::Update(\|IUP::Update)?>!L<Update|[%m.elem%]/"Update()">!sg;
  
  #$new =~ s!L<([A-Z0-9_]*)\|\.\./call/([A-Za-z_0-9]*)\.html>!AAA!s;
  #$new =~ s!^  *use  *IUP; *$! use IUP ':all';!m;
  
  $new =~ s!^(=item [BL]<[A-Z][A-Z][^>]*>)\s*([\[\(].*)$!$1\n\nI<$2>!mg;
  
  #if ($txt =~ /^(.*?)(\n\[%\s*h.at\s*%\].*\n\[%\s*txt.at_common\s*%\])(.*)$/s) {
  #  my ($pre, $main, $post) = ($1, $2, $3);
  #  for (split "\n", $main) {
  #    print $_, "\n" if /^=item \* [BL]<[A-Z][A-Z]/;
  #  }
  #  $main =~ s/\n=item \* /\n=item /sg;
  #  $new = $pre . $main . $post;
  #}
  
  ### write the output
  next unless $new ne $txt;
  push @changed, $f;
  if($DBG) {
    warn $txt;
    die $new;
  }
  else {
    write_file( $f, {binmode=>':raw'}, $new ) ;
  }
}

warn "changed.count=", scalar(@changed), "\n";