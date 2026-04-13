<x-admin::layouts>
    <x-slot:title>
        @lang('admin::app.marketing.communications.contact-forms.title')
    </x-slot>

    <div class="mt-3 flex items-center justify-between gap-4 max-sm:flex-wrap">
        <p class="text-xl font-bold text-gray-800 dark:text-white">
            @lang('admin::app.marketing.communications.contact-forms.title')
        </p>

        <div class="flex items-center gap-x-2.5">
            <x-admin::datagrid.export :src="route('admin.marketing.communications.contact_forms.index')" />
        </div>
    </div>

    <x-admin::datagrid :src="route('admin.marketing.communications.contact_forms.index')" />
</x-admin::layouts>
